all: estimate_repeat estimate_multiple_poissons

estimate_repeat: estimate_repeat.cpp gzstream.cpp
	g++ -o estimate_repeat estimate_repeat.cpp gzstream.cpp -lz 

estimate_multiple_poissons: estimate_multiple_poissons.cpp gzstream.cpp
	g++ -o estimate_multiple_poissons estimate_multiple_poissons.cpp gzstream.cpp -lz 

