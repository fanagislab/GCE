//Author: Binghang Liu
//Modified by Wei fan, fanwei@caas.cn, at 2020/2/25

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <cmath>
#include <stdint.h>

using namespace std;

typedef long double ld_t;

const double e = 2.718281828;
const double pi = 3.14159265;

string file; //kmer freq file.
double a_dis_cut_off=0.0001;
double cvg_dis_cut_off=0.0001;
int iter_cut_off=10000;
int c_iter_cut_off=100;
int hybrid=0; //use hybrid mode or not.
int bias = 0; //have high depth bias or not, set for real sequencing data.
int mode = 0; //use discrete model(0) or continuous model(1)
double cvg=0;
double Cvg=0;
int dis = 1; //distance between peaks.
int Depth_Num=1500; //max depth cut off, space of depth: 256 for one-byte space, and 65536 for two-byte space


uint64_t node_num=0;
uint64_t kmer_num = 0;
int64_t now_node=0;
int64_t now_kmer=0;
int64_t low_kmer_num=0; //used for modifying the total kmer number.
int64_t Low_kmer_num=0;

ld_t *factorials; //keep factorial result.
double **p; //keep P(j|i) for ai.
double **P; //keep for bi.
double *pp; //pi is temp ai or bi.
double *c; //ci for ai.
double *C; //ci for bi.
double *a; //ai.
double *b; //bi.

ld_t *sumj; //the denominator.

ld_t *freq;
ld_t *freqnew;
ld_t *init;
ld_t *final;
ld_t *Freq;
ld_t *Freqnew;
ld_t *Final;
int peak_num;
int valley, raw_peak;
int Valley, Raw_peak;
/*
	###################################################
		basic fuctions
	###################################################
*/

void load_freq(string &file, ld_t *freq, ld_t *Freq)
{
	cerr<<"Load kmer depth frequency file...\n";
	ifstream infile(file.c_str());
	if(!infile)
	{
		cerr<<"fail open file: "<< file<<endl;
		exit(0);
	}
	ld_t num;
	string str, depth;
	bool keep=0;
	if(kmer_num == 0)
		keep = 1;
	else
		cerr<<"Set total kmer number is "<< kmer_num<<endl;

	int depth_num=1;

	while(infile >> depth >> num)
	//while(infile >>num)
	{
		freq[depth_num]=num;
		Freq[depth_num] = depth_num*num;
		node_num += num;
		if(keep)
			kmer_num+= depth_num*num;
		depth_num++;
		getline(infile, str, '\n');
		if(depth_num >= Depth_Num)    //Modified by Wei Fan, old version: if(depth_num > Depth_Num)
			break;
	}
	
	infile.close();
	cerr<<"File load finished, the last depth is "<< depth <<endl;
}

ld_t factorial(ld_t j)
{
	if(j==1 || j==0)
		return 1;
	return j*factorial(j-1);
}

void set_factorials(ld_t *factorials)
{
	for(int i=0; i<Depth_Num; i++)
		factorials[i] = factorial(i);
}

//ci = cvg[i];
void inital_array(int peak_num, double* cvg, double **p, bool flag) //cal p.
{	
	//cal p matrix.
	int j;
	for(int i=1; i<=peak_num; i++)
	{
		if(cvg[i] < 22)
		{
			if(!flag){
				p[i][0] = 0;
			}else{
				p[i][0]=ld_t(pow(cvg[i],0))*ld_t(pow(e, -cvg[i]))/factorials[0];
			}
			for(j=1; j<Depth_Num; j++)
			{
				if(!flag){
					p[i][j]=ld_t(pow(cvg[i],j-1))*ld_t(pow(e, -cvg[i]))/factorials[j-1];
				}else{
					p[i][j]=ld_t(pow(cvg[i],j))*ld_t(pow(e, -cvg[i]))/factorials[j];
				}
				if(j > cvg[i] && p[i][j] < 1e-30)
					break;
			}
			for(;j<Depth_Num; j++)
				p[i][j]=0;
		}else{
			if(!flag){
				p[i][0] = 0;
			}else{
				p[i][0]=pow(e,-(ld_t(0-cvg[i])*ld_t(0-cvg[i])/ld_t(2*cvg[i])))/sqrt(2*pi*cvg[i]);
			}
			for(j=1; j<Depth_Num; j++)
			{
				if(!flag){
					p[i][j]=pow(e,-(ld_t(j-1-cvg[i])*ld_t(j-1-cvg[i])/ld_t(2*cvg[i])))/sqrt(2*pi*cvg[i]);
				}else{
					p[i][j]=pow(e,-(ld_t(j-cvg[i])*ld_t(j-cvg[i])/ld_t(2*cvg[i])))/sqrt(2*pi*cvg[i]);
				}
				if(j > cvg[i] && p[i][j] < 1e-30)
					break;
			}
			for(;j<Depth_Num; j++)
				p[i][j]=0;
		}
	}
}

//recognize the peak.
void get_peaks(ld_t *freq, int &peak, int &valley, double cvg, int hybrid)
{
	int *peaks=new int[Depth_Num];
	int *peakp=new int[Depth_Num];
	uint64_t min_num=freq[1], min=1, peak_num=0, max_peak=0, max_value=0;
	bool decrease = 1;
	
	for(int i=2; i<Depth_Num-1; i++)
	{
		peaks[i]=0;
		peakp[i]=0;
		if(freq[i] < min_num && decrease)
		{
			min_num = freq[i];
			min = i;
			decrease = 1;
		}else if(decrease)
			decrease = 0;

		if(i > min && freq[i] > max_value)
		{
			max_peak = i;
			max_value=freq[i];
		}

	}
	if(min != 1)
		peaks[1]=-1;
	else
		peaks[1]=1;
	peakp[0]=0;
	peakp[1]=0;
	for(int i=2; i<Depth_Num-2; i++)
	{

		if(freq[i] > freq[i-1] && freq[i] > freq[i+1]){
			peaks[i]=2;
			peak_num++;
		}else if(freq[i] < freq[i-1] && freq[i] < freq[i+1]){
			peaks[i]=-2;
		}else if(freq[i] > freq[i-1]){
			peaks[i]=1;
		}else if(freq[i] >freq[i+1]){
			peaks[i]=-1;
		}
	}
	int check_num =2;
	//cerr<< "Raw recognized peak number is " << peak_num<<endl;
	cerr<< "Possible peaks including: ";
	peak_num=0;
	for(int i=2; i<Depth_Num-2;i++)
	{
		if(peaks[i] == 2)
		{
			int j;
			for(j=i-check_num; j<i; j++)
			{
				if(j>=1 && peaks[j] != 1)
					break;
			}
			if(j != i && i != max_peak && abs(i-cvg) > 3)
			{
				if(peaks[j] == -1)
					peaks[i] = -1;
				else
					peaks[i]=0;
				continue;
			}
			for(j=i+1; j< i+ check_num; j++)
			{
				if(j<Depth_Num && peaks[j] != -1)
					break;
			}
			if(j != i+check_num && i != max_peak && abs(i-cvg) > 3)
			{
				if(peaks[j] == 1)
					peaks[i] = 1;
				else
					peaks[i] =0;
				continue;
			}
			peakp[peak_num]=i;
			cerr<<i<<"\t";
			peak_num++;
		}
	}
	cerr<<endl;
	if(peaks[max_peak] != 2 && abs(max_peak - cvg)<3)
	{
		cerr<<"no clear peak at "<<max_peak<<", do not suggest to estimate the genome size or ai.\n";
		exit(0);
	}
	peak = 0;
	if(hybrid)
	{
		if(abs(max_peak*2 - cvg) <= 3)
		{
			cerr<<"max peak is hybrid peak!\n";
			for(int i=max_peak+1; i< max_peak*2.5; i++) //check if there is main peak exists.
			{
				if(peaks[i] == 2 ) //have a peak after half peak.
				{
					if(min == 1)
						peak = int((i+max_peak*2.0)/2.0);
					else{
						peak = int(max_peak*2.0);
					}
					break;
				}
			}
			if(peak == 0)
			{
				peak = int(max_peak*2.0);
			}
		}else if(abs(max_peak - cvg) <=3){
			cerr<<"max peak is unique peak!\n";
			for(int i=int(cvg/4.0); i< max_peak; i++ )
			{
				if(i < 3)
					continue;
				if(peaks[i] == 2 && abs(i*2 - cvg) <=3) //check if there is half peak exists.
				{
					peak = i*2;
					break;
				}
			}
			if(peak == 0)
			{
				peak = max_peak;
			}
		}else{
			cerr<<"max peak unkown!\n";
			int near=0, near_diff=cvg, near_i=0;
			for(int i=0; i< peak_num; i++)
			{
				int diff = abs(peakp[i]-cvg);
				if(diff < near_diff)
				{
					near_diff=diff;
					near = peakp[i];
					near_i = i;
				}
			}
			cerr<<"the unique peak is " << near<<endl;
			if(near_i == 1)
			{
				cerr<<"have hybrid peak!\n";
				if(min == 1)
				{
					peak = int(double(peakp[0]*2.0+ peakp[1])/2.0);
				}else
					peak = peakp[0]*2;
			}else{
				cerr<<"do not have hybrid peak!\n";
				peak = near;
			}
		}
	}else{
		peak = max_peak;
		if(cvg > 1)
		{
			int near=0, near_diff=cvg, near_i=0;
			for(int i=0; i< peak_num; i++)
			{
				int diff = abs(peakp[i]-cvg);
				if(diff < near_diff)
				{
					near_diff=diff;
					near = peakp[i];
					near_i = i;
				}
			}
			cerr<<"the unique peak is " << near<<endl;
			peak = near;
		}
	}
	if(min< peak)
		valley = min;
	else
		valley = 0;
	if(valley == 1)
		valley = 0;
	//cerr<<"peak is " << peak <<" valley is " << valley<<" min is "<< min<<endl;	
	delete []peaks;
	delete []peakp;
}

//poisson distribution peak ratio for ai.
void set_init(ld_t *init, double cvg, int peak_num)
{
	for(int i=0; i< Depth_Num; i++)
		init[i]=0;
	
	//cerr<<"theoretical Poission distribution peak value:\n";
	for(int i=1; i<= peak_num; i++)
	{
		if(double(i)/dis*cvg <= 22)
			init[int(double(i)/dis*cvg)]=ld_t(pow(int(cvg*double(i)/dis), int(double(i)/dis*cvg))*pow(e, -int(double(i)/dis*cvg)))/factorials[int(double(i)/dis*cvg)]; //attention here.
		else
			init[int(double(i)/dis*cvg)]=1.0/sqrt(2*pi*double(i)/dis*cvg);
		//cerr<<int(double(i)/dis*cvg)<<"\t"<<init[int(double(i)/dis*cvg)]<<endl;
	}
}

//get ai,0.
double get_raw(double freq, double init)
{
	if(freq >init)
		return 1;
	return (freq/init);
}

//get kmer frequency curve from ai.

void set_freqy(ld_t *array, double *a, double **p, int peak_num, double* cvg, int64_t node, int mask)
{
	double value;
	for(int i=1; i<=peak_num; i++)
	{
		if(a[i] < 1e-10 || i == mask)
			continue;
		for(int j=0; j<Depth_Num; j++)
		{
			value = node * a[i] * p[i][j];
			if(value < 1e-10 && j > cvg[i])
				break;
			array[j] += value;
		}
	}
}

void set_freq0(ld_t *freqnew, double *a, double* cvg, int peak_num, int64_t &node, int flag)
{
	if(!flag)
	{
		freqnew[0] = 0;
		return;
	}
	ld_t freq0=0;
	for(int i=1; i<= peak_num; i++)
		freq0 += a[i]*pow(e, -cvg[i]);
	node = node *(1 + freq0/(1.0-freq0));
	freqnew[0] = node * freq0;
}

double cvg_modify(ld_t *freq, double *a, double **p, int peak_num, double cvg, double *c, int64_t now_node, int hybrid, bool flag)
{
	double value;
	ld_t *tmp=new ld_t[Depth_Num];
	for(int j=1; j<Depth_Num; j++)
		tmp[j] = 0;
	int mask_peak = dis;
	set_freqy(tmp, a, p, peak_num, c, now_node, mask_peak);
	for(int j=1; j<Depth_Num; j++)
	{
		tmp[j] = freq[j] - tmp[j];
	}
	int nowvalley;
	int nowpeak;
	get_peaks(tmp, nowpeak, nowvalley, cvg, hybrid);
	double u_cvg = tmp[nowpeak+1]/tmp[nowpeak]*double(nowpeak+1);
	//double u_cvg = peak_cvg(tmp, nowpeak, 1);
	
	if(!flag)
	{
		u_cvg = tmp[nowpeak+1]/tmp[nowpeak]*double(nowpeak);
//		cerr<<"update cvg2 is: "<< tmp[nowpeak+1]/tmp[nowpeak]*double(nowpeak)<<endl;
	}
	
	//cerr<<"Update peak: "<< nowpeak <<" cvg: "<< u_cvg<<endl;
	delete []tmp;
	return u_cvg;
}

uint64_t error_remove(ld_t *freq, ld_t *freqnew, double *a, double **p, double *cvg, int raw_peak, uint64_t node, int peak_num, int valley, int flag)
{
	ld_t low_node_sum=0, low_kmer_sum=0;
	int64_t now_num;

	ld_t *tmp = new ld_t[Depth_Num];
	for(int i=0; i< Depth_Num; i++)
		tmp[i]=0;

	set_freqy(tmp, a, p, peak_num, cvg, node, 0);
	for(int i=0; i< Depth_Num; i++)
	{
		//if(tmp[i] < freq[i] && i < raw_peak*3.0/4.0)
		if(tmp[i] < freq[i] && i < valley*1.2)
		{
			low_node_sum += freq[i] - tmp[i];
			low_kmer_sum += i*(freq[i] - tmp[i]);
			freqnew[i]=tmp[i];
		}else
			freqnew[i]=freq[i];
	}
	
	if(flag)
	{
		now_num = node_num - low_node_sum;
		//now_num = node - low_node_sum;
		low_kmer_num = low_kmer_sum;
	}else{
		now_num = kmer_num - low_kmer_sum;
		//now_num = node - low_kmer_sum;
		Low_kmer_num = low_kmer_sum;
	}
	delete []tmp;
	return now_num;
}

uint64_t error_remove(ld_t *freq, ld_t *freqnew, uint64_t node_num, double cvg, int valley, int hybrid, bool flag)
{
	ld_t lowsum=0, new_value, xh, xn; //hybrid x value and normal x value.
	uint64_t now_node;
	if(flag)
		low_kmer_num = 0; //global
	else
		Low_kmer_num=0;
	int start;
	if(valley)
	{
		//method 1, from the valley.
		//start = valley +1;
		//method 2, from the peak.
		if(hybrid)
			start = int(cvg/2.0)-1;
		else{
			start = int(cvg*0.5); //more accurcy than cvg-1.
			if(start < valley +2)
                        	start = cvg-1;
		}
		new_value = freq[start+1];
		if(hybrid)
		{
			xh = freq[start]*ld_t(cvg)/ld_t(start+1)-new_value;
			xn = new_value - xh;
		}
	}else{
		start = -1;
	}
	for(int j= start; j>=0; j--)
	{
		if(!hybrid)
		{
			//if(j <cvg/2)
				new_value = new_value *ld_t(j+1)/ld_t(cvg);
			//else
			//	new_value = freq[int(2*cvg-j)];
		}else{
			xh = xh * ld_t(j+1)/ld_t(cvg/2);
			xn = xn * ld_t(j+1)/ld_t(cvg);
			new_value = xh + xn;
		}
		if(freq[j] - new_value > 0)
		{
			lowsum += (freq[j] - new_value);
			if(flag)
				low_kmer_num += (freq[j] - new_value)*j;
			else
				Low_kmer_num += (freq[j] - new_value);
			freqnew[j]= new_value;
		}else{ // add.
			new_value = freq[j];
			freqnew[j]= new_value;
		}
	}
	int start2 = int(cvg/2.0) + 1;
	if(hybrid && valley)
	{
		new_value = freq[start2+1];
		xh = freq[start2]*ld_t(cvg)/ld_t(start2+1)-new_value;
		xn = new_value - xh;
	}
	for(int j=start+1; j< cvg; j++)
	{
		if(j > start2 && hybrid && valley)
		{
			xh = xh* ld_t(cvg/2)/ld_t(j+1);
			xn = xn * ld_t(cvg)/ld_t(j+1);
			new_value = xh + xn;
			if(freq[j] - new_value > 0)
			{
				lowsum += (freq[j] - new_value);
				if(flag)
				{
					low_kmer_num += (freq[j] - new_value)*j;
				}else{
					Low_kmer_num += (freq[j] - new_value);
				}
				freqnew[j]= new_value;
			}else{
				new_value = freq[j];
				freqnew[j]= new_value;
			}
		}else{
			freqnew[j]= freq[j];
		}
	}
	for(int j=cvg; j< Depth_Num; j++)
		freqnew[j]= freq[j];

	now_node = node_num - lowsum;
	//cerr<<"Node number after intial error remove is " << now_node<<" and low depth k-mer number is "<< lowsum <<endl;
	return now_node;
}

void update_a(double *a, int peak_num)
{
	double sum=0;
	for(int i=1; i< peak_num; i++)
		sum += a[i];
	for(int i=1; i< peak_num; i++)
		a[i] = a[i]/sum;
	a[peak_num]=0;
}


void discrete_model()
{
	cerr<<"start iterating using discrete model...\n";
	double a_dis=1.0, c_dis = 1.0;
	int iter=0, c_iter =0; //iter number.

	ld_t sum_xp=0, sum_ai=0, Sum_xp=0, Sum_ai=0;

	int64_t now_node1 = now_node;
	int64_t now_kmer1 = now_kmer;
	
	while(c_dis > cvg_dis_cut_off && c_iter < iter_cut_off)
	{
		c_iter++;
		if(c_iter > 1) //update c, p and node_num.
		{
			cerr<<"For P(x):"<<endl;
			double u_cvg = cvg_modify(freqnew, a, p, peak_num, cvg, c, now_node, hybrid, 1);
			cerr<<"For F(x):"<<endl;
			double u_Cvg = cvg_modify(Freqnew, b, P, peak_num, Cvg, C, now_kmer, hybrid, 0);
			c_dis = abs(u_cvg-cvg)/cvg;
			if(c_dis <= cvg_dis_cut_off || c_iter > c_iter_cut_off)
			{
				break;
			}else{
				cvg = u_cvg;
				Cvg = u_Cvg;
				for(int i=1; i<= peak_num; i++)
				{
					c[i] = double(i)/double(dis)*cvg;
					C[i] = double(i)/double(dis)*Cvg;
				}
			}
			inital_array(peak_num, c, p, 1); //cal p.
			inital_array(peak_num, C, P, 0);
			
			now_node = error_remove(freq, freqnew, node_num, cvg, valley, hybrid, 1);
			now_kmer = error_remove(Freq, Freqnew, kmer_num, Cvg, Valley, hybrid, 0);
		}
		cerr<<"C-iter number: "<< c_iter<<"\tc distance: "<< c_dis <<endl;
		cerr<<"cvg is "<< cvg<<" and node num is "<< now_node<<endl;
		cerr<<"Cvg is "<< Cvg<<" and kmer num is "<< now_kmer<<endl;
		a_dis=1; 
		iter = 0;
		now_node1 = now_node;
		now_kmer1 = now_kmer;
		while(a_dis > a_dis_cut_off && iter < iter_cut_off)
		{
			iter++;
			cerr<<"A-iter number: "<< iter <<"\tdistance: "<<a_dis<< "\n";
			double sumi =0, pij;
			
			if(iter > 2 && valley )
			{
				now_node = error_remove(freq, freqnew, a, p, c, raw_peak, now_node, peak_num, valley, 1);
				now_kmer = error_remove(Freq, Freqnew, b, P, C, Raw_peak, now_kmer, peak_num, Valley, 0);
			}else{
				now_node = now_node1;
				now_kmer = now_kmer1;
			}
			
			//update freqnew.
			set_freq0(freqnew, a, c, peak_num, now_node, 1); //update freqnew 0 and now_node.
			set_freq0(Freqnew, b, C, peak_num, now_kmer, 0); //update Freqnew 0 and now_kmer.
			cerr<<"update now num: "<< now_node <<" now kmer: "<< now_kmer<<endl;
			double sum_c=0, sum_a=0, sum_ia=0;
			//cal a[i].
			for(int j=0; j< Depth_Num; j++)
			{
				sumj[j]=0;
				for(int i=1; i<=peak_num; i++)
				{
					if(a[i]< 1e-10)
						continue;
					sumj[j] += a[i]*p[i][j];
				}
			}
			for(int k=1; k<=peak_num; k++)
			{
				ld_t sum=0;

				for(int j=0; j<Depth_Num; j++)
				{
					if(a[k]< 1e-10)
						continue;
					if(sumj[j] == 0)
						continue;
					sum += ld_t(freqnew[j]*a[k]*p[k][j])/ld_t(sumj[j]*now_node);
				}
				pp[k] = sum;
				sum_a += sum;
			}
			a_dis = 0;

			for(int i=1; i<=peak_num; i++)
			{
				//pp[i] = pp[i]/sum_a;
				if(a[i] > 0)
					a_dis += abs(a[i] - pp[i]);///a[i];
				a[i] = pp[i];
				//c[i] = double(i)/double(dis) * cvg;

			}
			a_dis = a_dis/peak_num;

			//inital_array(peak_num, c, p);
			//cal b[i].
			for(int j=0; j<Depth_Num; j++)
			{
				sumj[j]=0;
				for(int i=1; i<=peak_num; i++)
				{
					if(b[i]< 1e-10)
						continue;
					sumj[j] += b[i]*P[i][j];
				}
			}
			sum_c = 0; sum_a=0; sum_ia=0;
			for(int k=1; k<=peak_num; k++)
			{
				ld_t sum=0;
				for(int j=0; j<Depth_Num; j++)
				{
					if(b[k]<1e-10)
						continue;
					if(sumj[j] == 0)
						continue;
					sum += ld_t(Freqnew[j]*b[k]*P[k][j])/ld_t(now_kmer * sumj[j]);
					sum_c += j * ld_t(Freqnew[j]*b[k]*P[k][j])/(now_kmer*sumj[j]);
				}
				pp[k] = sum;
				sum_a += sum;
				sum_ia += double(k)*sum/double(dis);
			}
			double Distance = 0;
			for(int i=1; i<=peak_num; i++)
			{
				//pp[i] = pp[i]/sum_a;
				if(b[i] > 0)
					Distance += abs(b[i] - pp[i])/b[i];
				b[i] = pp[i];
				//C[i] = double(i)/double(dis)*Cvg;
			}
			Distance = Distance/peak_num;
			//inital_array(peak_num, C, P);
		}
		//break;
	}
	
	if(bias)
		update_a(a, peak_num);

	cout<<"#ai table:\n#i\tc[i]\ta[i]\tC[i]\tb[i]\n";
	for(int i=1; i<= peak_num; i++)
	{
		if(hybrid){
			cout<<i/2.0<<"\t"<<c[i]<<"\t"<<a[i]<<"\t"<<C[i]<<"\t"<<b[i]<<endl;
		}else{
			cout<<i<<"\t"<<c[i]<<"\t"<<a[i]<<"\t"<<C[i]<<"\t"<<b[i]<<endl;
		}
	}
	set_freqy(final, a, p, peak_num, c, now_node, 0);
	set_freqy(Final, b, P, peak_num, C, now_kmer, 0);

	cout<<"#depth\treal_P(x)\treal_F(x)\test_P(x)\test_F(x)\n";
	for(int i=1; i< Depth_Num; i++)
	{
		if(init[i]<1e-10 && final[i] < 1e-10)
			continue;
		cout<<i<<"\t"<<freq[i]/double(node_num)<<"\t" <<Freq[i]/double(kmer_num)<<"\t"
			<<final[i]/double(node_num)<<"\t"<<Final[i]/double(kmer_num)<<endl;
	}

	//The output format is modifed by fanwei, change now_kmer to (kmer_num - low_kmer_num)
	if(hybrid)
	{
		cerr<<"for hybrid: a[1/2]="<< a[1]<<" a1="<< a[2]<<endl;
		cerr<<"kmer-species heterozygous ratio is about "<< a[1]/(2 - a[1])<<endl;
		cerr<<"for hybrid: b[1/2]="<< b[1]<<" b1="<< b[2]<<endl;
		cerr<<"kmer-individual heterozygous ratio is about "<< b[1]/(2 - b[1])<<endl;
  	cerr<<"\nFinal estimation table:\n";	
  	cerr<<"raw_peak\teffective_kmer_species\teffective_kmer_individuals\tcoverage_depth\tgenome_size\ta[1/2]\ta[1]\tb[1/2]\tb[1]\n";
  	cerr<<raw_peak<<"\t"<<now_node <<"\t"<< kmer_num - low_kmer_num << "\t"<< cvg<<"\t"<<double(kmer_num - low_kmer_num)/cvg<<"\t"
  	    <<a[1]<<"\t"<<a[2]<<"\t"<<b[1]<<"\t"<<b[2]<<endl;
	}else{
  	cerr<<"\nFinal estimation table:\n";	
  	cerr<<"raw_peak\teffective_kmer_species\teffective_kmer_individuals\tcoverage_depth\tgenome_size\ta[1]\tb[1]\n";
  	cerr<<raw_peak<<"\t"<<now_node <<"\t"<< kmer_num - low_kmer_num << "\t"<< cvg<<"\t"<<double(kmer_num - low_kmer_num)/cvg<<"\t"
  	    <<a[1]<<"\t"<<b[1]<<endl;
	}
	cerr<<"\nDiscrete mode estimation finished!"<<endl;

}

//recognize the final cvg for continuous model.
double get_final_cvg(double *a, double* cvg, double coverage, int peak_num, int hybrid)
{
	double max_value=0, c, max2_value=0;
	int max_i=0, max2_i=0;
	for(int i=0; i<= peak_num; i++)
	{
		if(cvg[i] > 2*coverage || cvg[i] < 0.5*coverage)
			continue;
		if(a[i] > max_value)
		{
			max2_value = max_value;
			max2_i = max_i;
			max_value= a[i];
			max_i = i;
		}else if(a[i] > max2_value)
		{
			max2_value = a[i];
			max2_i = i;
		}
	}
	cerr<<"max i "<< max_i <<" max a "<< max_value<<" c is "<< cvg[max_i] <<endl; 
	//c = max_i * cvg /double(dis);
	//if(max2_i == max_i + 1)
	if(a[max_i+1] >= a[max_i]*0.85)
	{
		if(a[max_i+1] < a[max_i-1]) //for real data.
			c = (a[max_i]*cvg[max_i]+a[max_i+1]*cvg[max_i+1] + a[max_i-1]*cvg[max_i-1])/(a[max_i-1] + a[max_i] + a[max_i+1]);
		else //for simulation data.
			c = (a[max_i]*cvg[max_i]+a[max_i+1]*cvg[max_i+1])/(a[max_i] + a[max_i+1]);
	}else{
		c = cvg[max_i];
	}
	double max_diff = 3;
	if(hybrid && abs(2*c - coverage)< max_diff)
	{
		cerr<<"Severe hybrid, main peak moved!\n";
		c = 2*c;
		max_value=0, max_i=0;
		int first_value=0;
		for(int i=0; i<= peak_num; i++)
		{
			if(cvg[i] < c- max_diff || cvg[i] < c/2+2)
				continue;
			if(cvg[i] > c+ max_diff)
				break;
			if(first_value == 0)
				first_value = i;
			if(max_value < a[i])
			{
				max_value = a[i];
				max_i = i;
			}
		}
		if(max_i == first_value)
		{
			cerr<<"no main peak find!\n";
		}else
			c = (cvg[max_i]+c)/2.0;
	}
	return c;
}

void get_unique(double &ah, double &au, double *a, double *c, double cvg, int peak_num, int dis, int hybrid, bool flag)
{
	int distance = 1;
	if(hybrid)
		distance = 2;
	double an=0, a1;
	if(dis == 1 )
	{	au = a[1];
		return;
	}
	if(dis == 2 && hybrid)
	{
		ah = a[1];
		au = a[2];
		return;
	}
	double *aa=new double[2*distance+1];
	for(int i=0; i< 2*distance+1; i++)
		aa[i]=0;

	int j=1;
	double v1 = cvg*double(j)/double(distance);
	double v2 = cvg*double(j+1)/double(distance);

	for(int i=1; i< peak_num; i++)
	{
		if(c[i]<=v1)
			aa[j] += a[i];
		else if(c[i] <= v2)
		{
			if(abs(v2-c[i])/abs(v2-v1) <= 0.3)
			{
				aa[j+1] += a[i];
			}else if(abs(v1-c[i])/abs(v2-v1) <= 0.3)
			{
				aa[j] += a[i];
			}else{
				aa[j] += a[i]*abs(v2-c[i])/abs(v2-v1);
				aa[j+1] += a[i] *abs(v1-c[i])/abs(v2-v1);
			}
		}else{
			v1 = v2;
			j++;
			if(j >= 2* distance)
				break;
			v2 = cvg*double(j+1)/double(distance);
			if(abs(v2-c[i])/abs(v2-v1) <= 0.3)
			{
				aa[j+1] += a[i];
			}else if(abs(v1-c[i])/abs(v2-v1) <= 0.3)
			{
				aa[j] += a[i];
			}else{
				aa[j] += a[i]*abs(v2-c[i])/abs(v2-v1);
				aa[j+1] += a[i] *abs(v1-c[i])/abs(v2-v1);
			}
		}
	}

	if(hybrid)
	{
		a1 = (aa[2] + aa[1]/2.0)/(1.0- aa[1]/2.0) ;
		if(flag){
			cerr<<"for hybrid: a[1/2]="<< aa[1]<<" a1="<< aa[2]<<endl;
			cerr<<"kmer-species heterozygous ratio is about "<< aa[1]/(2 - aa[1])<<endl;
		}else{
			cerr<<"for hybrid: b[1/2]="<< aa[1]<<" b1="<< aa[2]<<endl;
			cerr<<"kmer-individual heterozygous ratio is about "<< aa[1]/(2 - aa[1])<<endl;
		}
		ah = aa[1]; au = aa[2];
	}else{
		au = aa[1];
	}
}


void continuous_model()
{
	cerr<<"start iterating using continuous model...\n";
	double distance=1.0;
	int iter=0; //iter number.
	
	ld_t sum_xp=0, sum_ai=0, Sum_xp=0, Sum_ai=0;

	int64_t now_node1 = now_node;
	int64_t now_kmer1 = now_kmer;
	
	while(distance > a_dis_cut_off && iter < iter_cut_off)
	{
		iter++;
		cerr<<"iter: "<< iter << "\tdistance: "<<distance<<"\t";
		double sumi =0, pij;
		now_node = now_node1;
		now_kmer = now_kmer1;
		
		if(iter > 2 && valley)
		{
			now_node = error_remove(freq, freqnew,a, p, c, raw_peak, now_node, peak_num, valley, 1);
			now_kmer = error_remove(Freq, Freqnew,b, P, C, Raw_peak, now_kmer, peak_num, Valley, 0);
		}
		
		//update freqnew.
		set_freq0(freqnew, a, c, peak_num, now_node, 1); //update freqnew 0 and now_node.
		set_freq0(Freqnew, b, C, peak_num, now_kmer, 0); //update Freqnew 0 and now_kmer.
		cerr<<"update node num: "<< now_node <<" kmer num: " << now_kmer<<endl;
		if(now_node > 10* node_num)
		{
			cerr<<"Fail estimated!\n";
			return ;
		}
		double sum_c[peak_num+1], sum_a=0;
		//cal a[i].
		for(int j=0; j< Depth_Num; j++)
		{
			sumj[j]=0;
			for(int i=1; i<=peak_num; i++)
			{
				if(a[i]< 1e-10)
					continue;
				sumj[j] += a[i]*p[i][j];
			}
		}

		for(int k=1; k<=peak_num; k++)
		{
			ld_t sum=0;
			sum_c[k]=0;
			
			for(int j=0; j<Depth_Num; j++)
			{
				if(a[k]< 1e-10)
					continue;
				if(sumj[j] == 0)
					continue;
				sum += ld_t(freqnew[j]*a[k]*p[k][j])/(sumj[j]*now_node);
				sum_c[k] += j * ld_t(freqnew[j]*a[k]*p[k][j])/(sumj[j]*now_node);
			}
			
			pp[k] = sum;
			if(sum == 0)
				sum_c[k]=0;
			else
				sum_c[k] = sum_c[k]/pp[k];
			if(sum_c[k] < valley)
				sum_c[k]=0;
			sum_a += sum;
		}
		distance = 0;
		for(int i=1; i<=peak_num; i++)
		{
			pp[i] = pp[i]/sum_a;
			distance += abs(a[i] - pp[i])+abs(c[i] - sum_c[i]);
			a[i] = pp[i];
			c[i] = sum_c[i];
		}
		distance = distance/peak_num/2;
		inital_array(peak_num, sum_c, p, 1);
		//cal b[i].
		for(int j=0; j<Depth_Num; j++)
		{
			sumj[j]=0;
			for(int i=1; i<=peak_num; i++)
			{
				if(b[i]< 1e-10)
					continue;
				sumj[j] += b[i]*P[i][j];
			}
		}

		for(int k=1; k<=peak_num; k++)
		{
			ld_t sum=0;
			sum_c[k]=0;
			for(int j=0; j<Depth_Num; j++)
			{
				if(b[k]<1e-10)
					continue;
				if(sumj[j] == 0)
					continue;
				sum += ld_t(Freqnew[j]*b[k]*P[k][j])/(now_kmer*sumj[j]);
				sum_c[k] += j * ld_t(Freqnew[j]*b[k]*P[k][j])/(now_kmer*sumj[j]);
			}
	
			pp[k] = sum;
			if(sum == 0)
				sum_c[k]=0;
			else
				sum_c[k] = sum_c[k]/pp[k];
			if(sum_c[k] < Valley)
				sum_c[k]=0;
		}
		double Distance = 0;
		for(int i=1; i<=peak_num; i++)
		{
			Distance += abs(b[i] - pp[i]);///a[i];
			b[i] = pp[i];
			C[i] = sum_c[i];
		}
		Distance = Distance/peak_num;
		inital_array(peak_num, sum_c, P, 0);
	}
	
	if(bias)
		update_a(a, peak_num);
	
	cout<<"#ai table:\n#i\tc[i]\ta[i]\tC[i]\tb[i]\n";
	for(int i=1; i<= peak_num; i++)
	{
			cout<<i<<"\t"<<c[i]<<"\t"<<a[i]<<"\t"<<C[i]<<"\t"<<b[i]<<endl;
	}
	set_freqy(final, a, p, peak_num, c, now_node,0);
	set_freqy(Final, b, P, peak_num, C, now_kmer,0);

	cout<<"#depth distribution table:\n#depth\treal_P(x)\treal_F(x)\test_P(x)\test_F(x)\n";
	for(int i=1; i< Depth_Num; i++)
	{
		if(init[i]<1e-10 && final[i] < 1e-10)
			continue;
		cout<<i<<"\t"<<freq[i]/double(node_num)<<"\t" <<Freq[i]/double(kmer_num)<<"\t"
			<<final[i]/double(node_num)<<"\t"<<Final[i]/double(kmer_num)<<endl;
	}

	if(dis > 2)
	{
		cvg = get_final_cvg(a, c, cvg, peak_num, hybrid);
		Cvg = get_final_cvg(b, C, Cvg, peak_num, hybrid);
	}
	double ah = 0, au = 0, bh = 0, bu = 0;
	get_unique(ah, au, a, c, cvg, peak_num, dis, hybrid, 1);
	get_unique(bh, bu, b, C, Cvg, peak_num, dis, hybrid, 0);
	
	//The output format is modifed by fanwei, change now_kmer to (kmer_num - low_kmer_num)
	cerr<<"\nFinal estimation table:"<<endl;
	if(hybrid){
		cerr<<"raw_peak\teffective_kmer_species\teffective_kmer_individuals\tcoverage_depth\tgenome_size\ta[1/2]\ta[1]\tb[1/2]\tb[1]\n";
		cerr<<raw_peak<<"\t"<<now_node<<"\t"<<kmer_num - low_kmer_num<< "\t"<< cvg <<"\t"<<double(kmer_num - low_kmer_num)/cvg<<"\t"
	  	  <<ah<<"\t"<<au<<"\t"<<bh<<"\t"<<bu<<endl;
	}else{
  	cerr<<"raw_peak\teffective_kmer_species\teffective_kmer_individuals\tcoverage_depth\tgenome_size\ta[1]\tb[1]\n";
  	cerr<<raw_peak<<"\t"<<now_node <<"\t"<<kmer_num - low_kmer_num<< "\t"<< cvg <<"\t"<<double(kmer_num - low_kmer_num)/cvg<<"\t"
  	    <<au<<"\t"<<bu<<endl;
	}
	
	cerr<<"\ncontinuous model estimation finished!\n";
}

void usage(void)
{
	cout<<"Usage:\t\tgce(genomic charactor estimator) [option]\n"
	    <<"Version:\t1.0.2\n"
	    <<"Author:\t\tBGI ShenZhen\n"
	    <<"Contact:\tbinghang.liu@qq.com; fanweiagis@126.com;\n"
	    <<"Date: \t"<<__DATE__<<"\t"<<__TIME__<<"\n"
			<<"\t-f	<string>	depth frequency file with two columns: depth value and kmer species number \n"
			<<"\t-c	<int>	expected depth for unique kmer, which can be obtained by checking the data with human eyes\n"
			<<"\t-g	<int>	total kmer number, i.e. total number of kmer individuals \n"
			<<"\t-b	<int>	have bias(1) or not(0), default=" << bias <<"\n"
			<<"\t-H	<int>	use hybrid mode(1) or not(0), default="<< hybrid <<"\n"
			<<"\t-m	<int>	estimation mode: discrete mode(0) and continuous mode(1), default="<< mode <<"\n"
			<<"\t-M	<int>	max depth value, information for larger depth will be ignored, default="<< Depth_Num<<"\n"
			<<"\t-D	<int>	precision of expect value, default=" << dis <<"\n"
			<<"\t-d	<float>	difference cut off, default="<< a_dis_cut_off<<"\n"
			<<"\t-i	<int>	iterate cycle number cut off, default=" << iter_cut_off <<"\n"
			<<"\t-h this help\n\n"
	    <<"Example:\n\n"
		<<"(1) Before run gce, firstly get the total kmer number and depth frequency file from the kmerfreq result file (example: AF.kmer.freq.stat) \n"
		<<"     less AF.kmer.freq.stat | grep \"#Kmer indivdual number\" \n"
		<<"     less AF.kmer.freq.stat | perl -ne 'next if(/^#/ || /^\\s/); print; ' | awk '{print $1\"\\t\"$2}' > AF.kmer.freq.stat.2colum \n\n"
		<<"(2) Run gce in homozygous mode, suitable for homozygous and near-homozygous genome (-g and -f must be set at the same time) \n     gce -g 173854609857 -f AF.kmer.freq.stat.2colum >gce.table 2>gce.log\n\n"
	    <<"(3) Run gce in heterzygous mode, siutable for heterozgyous genome (-H and -c must be set at the same time) \n     gce -g 173854609857 -f AF.kmer.freq.stat.2colum -c 75 -H 1 >gce2.table 2>gce2.log\n\n"
		<<"Attention:\n"
		<<"At most time, the homozygous and heterzygous status is not clear, you can first run gce in homozygous mode, to get the expected depth for unique kmer (option -c) from the result file (raw_peak), then re-run gce in heterozygous mode, and compare these estimation results by the two modes, to make a final conclusion.\n\n";

	exit(0);
}

int mGetOptions(int rgc, char *rgv[])
{
	int i;
	for(i=1; i<rgc; i++) {
		if(rgv[i][0]!='-')
			return i;
		switch(rgv[i][1]) {
			case 'f': file = rgv[++i];break;
			case 'c': cvg = atof(rgv[++i]); break;
			case 'n': node_num = strtol(rgv[++i],NULL,10);break;
			case 'g': kmer_num = strtol(rgv[++i],NULL,10);break;
			case 'b': bias = atoi(rgv[++i]);break;
			case 'H': hybrid = atoi(rgv[++i]); break;
			case 'm': mode = atoi(rgv[++i]);break;
			case 'M': Depth_Num = atoi(rgv[++i]);break;
			case 'd': a_dis_cut_off = atof(rgv[++i]);break;
			case 'D': dis = atof(rgv[++i]);break;
			case 'i': iter_cut_off = atoi(rgv[++i]);break;
			case 'h':usage();
			default: usage();
		}
	}
	return i;
}

int main(int argc, char* argv[])
{
	if( argc < 2 ) {
		usage();
	}

	mGetOptions(argc, argv);
	
	if(file.size() == 0)
	{
		cerr<<"Error: input the depth frequency file please!"<<endl;
		exit(-1);
	}
	
	if(hybrid && !cvg )
	{
		cerr<<"Error: unqiue coverage depth(-c) should be set while using hybrid mode(-H 1)! it is the depth of unqiue peak, you can roughly estimated\n";
		exit(-1);
	}
	
	if(mode == 1 && dis == 1)
	{
		cerr<<"Error: If you use the continous model(mode=1), you need to set -D at the same time\n";
		exit(-1);
	}

	//for keeping the kmer depth frequency distribution.
	freq= new ld_t[Depth_Num];
	freqnew = new ld_t[Depth_Num]; 
	init= new ld_t[Depth_Num];
	final= new ld_t[Depth_Num];
	Freq = new ld_t[Depth_Num];
	Freqnew = new ld_t[Depth_Num];
	Final = new ld_t[Depth_Num];

	for(int i=0; i< Depth_Num; i++)
	{
		freq[i]=0;
		Freq[i]=0;
		final[i]=0;
		Final[i]=0;
	}

	load_freq(file, freq, Freq);
	cerr<<"load node number "<< node_num <<" total kmer number "<< kmer_num <<endl;
	now_node= node_num;
	now_kmer = kmer_num;

	if(hybrid && dis == 1)
		dis = 2;
	
	//get cvg value.
	int peak=0, Peak=0 ;
	cerr<<"\nFor P(x):"<<endl;
	get_peaks(freq, peak , valley, cvg, hybrid);
	cerr<<"\nFor F(x):"<<endl;
	get_peaks(Freq, Peak, Valley, cvg+1, hybrid);

	raw_peak=peak;
	Raw_peak = Peak;
	
	cvg = (peak+1)*freq[peak+1]/freq[peak]; //for P(x)
	Cvg = (Peak)*Freq[Peak+1]/Freq[Peak]; //for F(x)
	//cerr<<"raw cvg2 is "<< (Peak)*Freq[Peak+1]/Freq[Peak]<<endl;
	cerr<<"\nRaw kmer depth estiamtion:\n";
	cerr<<"Curve\tpeak\texpect_depth\n";
	cerr<<"k-mer species " << peak <<"\t"<<cvg<< endl;
	cerr<<"k-mer individuals " << Peak <<"\t"<<Cvg<< endl<<endl;
	
	if(abs(Cvg - cvg) > 1)
	{
		cerr<<"Warning: the expect depths caculated by P(x) and F(x) are ambiguous, you'd better set the option -c to get a credible result."<<endl;
	}
	
	//decided the estimate peak number.
	peak_num = int(Depth_Num/cvg);
	
	if(peak_num >=6)
		peak_num=6;
	if(mode && dis == 1)
		dis = 8;

	if(dis > 1)
		peak_num = peak_num * dis;

	cerr<<"The estimate peak number is "<< peak_num <<endl;

	if(valley == 0)
		cerr<<"No valley, and may be no sequencing error!\n";
	else
		cerr<<"the valley value is "<< valley<<endl;

	//initially remove sequencing error. 
	now_node = error_remove(freq, freqnew, node_num, cvg, valley, hybrid, 1);
	now_kmer = error_remove(Freq, Freqnew, kmer_num, Cvg, Valley, hybrid, 0);

	//cal factorial array and p matrix.
	factorials = new ld_t[Depth_Num];  //keeping factorials.
	set_factorials(factorials);

	p = new double*[peak_num+1]; //p(j|i)
	P = new double*[peak_num+1];
	c = new double [peak_num+1];
	C = new double [peak_num+1];
	for(int i=0; i<= peak_num; i++)
	{
		p[i]= new double[Depth_Num];
		P[i]= new double[Depth_Num];
		c[i] = double(i)/double(dis)*cvg;
		C[i]=double(i)/double(dis)*Cvg;
	}

	inital_array(peak_num, c, p, 1);
	inital_array(peak_num, C, P, 0);

	//cal and output ai,0 and bi,0.
	cerr<<"Initial ai...\n";
	set_init(init, cvg, peak_num);
	
	a = new double [peak_num+1];
	b = new double [peak_num+1];
	
	cerr<<"i\ta[i]\tc[i]\n";
	for(int i=1; i<= peak_num; i++)
	{
		a[i]=get_raw( freqnew[int(cvg*double(i)/dis)]/double(now_node),  init[int(cvg*double(i)/dis)]);
		//a[i] = 1.0/peak_num;
		if(mode == 0 && hybrid){
			cerr<<i/2.0<<"\t"<<a[i]<<"\t"<<c[i]<<endl;
		}else{
			cerr<<i<<"\t"<<a[i]<<"\t"<<c[i]<<endl;
		}
	}
	set_init(init, Cvg, peak_num);
	cerr<<"i\tb[i]\tC[i]\n";
	for(int i=1; i<= peak_num; i++)
	{
		b[i]=get_raw( Freqnew[int(Cvg*double(i)/dis)]/double(now_kmer),  init[int(Cvg*double(i)/dis)]);
		if(mode == 0 && hybrid){
			cerr<<i/2.0<<"\t"<<b[i]<<"\t"<<C[i]<<endl;
		}else{
			cerr<<i<<"\t"<<b[i]<<"\t"<<C[i]<<endl;
		}
	}
	cerr<<"Initial ai and bi finished!\n";

	pp = new double[peak_num+1]; //pi is temp ai.
	sumj= new ld_t[Depth_Num]; //the denominator.

	if(!mode)
		discrete_model();
	else
		continuous_model();

	delete []factorials;
	delete []freq;
	delete []freqnew;
	delete []Freq;
	delete []Freqnew;

	delete []init;
	delete []final;
	delete []Final;
	delete []pp;
	delete []sumj;
	delete []a;
	delete []b;	
	delete []c;
	delete []C;

	for(int i=0; i<= peak_num; i++)
	{
		delete []p[i];
		delete []P[i];
	}
	delete []p;
	delete []P;
	return 0;
}
