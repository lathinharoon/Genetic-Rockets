# Genetic-Rockets
My First Project!

What is a Genetic algorithm?
The term “genetic algorithm” refers to a specific algorithm implemented in a specific way to solve specific sorts of problems. 
Genetic Programming (GP) is a type of Evolutionary Algorithm, a subset of machine learning. Evolutionary Algorithms are used to discover solutions to problems humans do not know how to solve, directly. Free of human preconceptions or biases, the adaptive nature of EAs can generate solutions that are comparable to, and often better than the best human efforts. 
Inspired by biological evolution and its fundamental mechanisms primarily based on Darwin’s theory of evolution, Genetic Programming software systems implement an algorithm that uses random mutation, crossover, a fitness function, and multiple generations of evolution to resolve a user-defined task.

Disciplines of Computer Science connected to Genetic Algorithm:
The field of Evolutionary Computation encompasses several types of evolutionary algorithm. These include Genetic Algorithms (GAs), Evolution Strategies, Evolutionary Programming and Learning Classifier Systems. 

History of Genetic Algorithms:
The first record of the proposal to evolve programs is that of Alan Turing in the 1950s. However, there was a gap of some thirty years before Richard Forsyth demonstrated the successful evolution of small programs, represented as trees, to perform classification of crime scene evidence for the UK Home Office.
In 1962, John Holland's work on adaptive systems laid the foundation for later developments. In 1975, Holland and his students published the book Adaptation in Natural and Artificial Systems based on the concept of Darwin’s theory of evolution; afterwards, his student David E. Goldberg extended GA in 1989. In 1992 John Koza has used genetic algorithm to evolve programs to perform certain tasks. He called his method "genetic programming" (GP).

My project:
In order to demonstrate how genetic algorithms, work and how they can be used to optimise any kind of problems. I will be creating a programme called Genetic Rockets. Genetic rocket is a simulation of rockets trying to reach its target quickly and efficiently as possible. 
Genetic rockets provide an elegant example of genetic algorithms. NASA uses evolutionary computing techniques to solve all kinds of problems, ranging from radio telescope scheduling to satellite antenna design to construction or rocket firing patterns. In a future of un-manned space probes, the long-term goal will be to have machines that can evolve to adapt to unexpected conditions. Such a machine might use genetic algorithms to evaluate a huge number of possible strategies, and to choose the one that is most likely to be a success. My simulation provides a realistic use of genetic algorithm. 

What are Genetic Rockets:
Genetic Rockets is a programme that uses Genetic Algorithm to create the best or the optimum rocket firing pattern to reach its target. My project is going to be a simulation of how the rockets evolve to find the optimum rocket firing patterns that uses smallest amount of fuel to fly to its target.

Features of the simulation:
For the simulation to fully depict the fundamental parts of the Genetic Algorithm, the user will have the ability to change some of the parameters. The functionalities that the user can expect from the programme are:
  •	Ability to change the mutation rate. The amount of mutation happening to the DNA of the rocket. To change the mutation rate, I’ll be adding a slider with discrete values from 0 to 1. This rate should be set low. If it is set too high, the search will turn into a primitive random search.
  •	Ability to change the population size. To change the population size, I’ll also be adding a slider which ranges from 50 to 500. The reason I have 500 as the maximum population size because of the limited computational power and if there were to have more rockets the programme will start to slow down and crash.
  •	Ability to change the maximum burn time available for the rockets to fire. To change the maximum burn time, I will also be using a slider ranging from 5 to 100 seconds.
  •	Ability, to change the velocity of the rockets, which ranges from 0 to 10. Which means when the velocity is equal to 0, the rockets will be frozen.
  •	Ability to toggle the adaptive mutation on or off. I am going to include the function to disable or enable the adaptive mutation function because adaptive mutation is not one of the options available on a traditional Genetic Algorithm.
  •	Ability to change the location of the target by simply left clicking on the location where the user wishes the target to be moved.
  •	Ability to see the fitness score of each rocket on the simulation window and able to turn them off.
  •	To draw different obstacle types.
  •	To be able to distinguish the best rocket in a population at any given time.
  •	To be able to save and load an obstacle layout.
  •	To be able to save and load a generation of rockets with the obstacles as well as data for the graph.
The simulation also will have an information tab where it’ll display the following information about the previous generation:
  o	No. of successful rockets that reached the target
  o	Highest fitness score
  o	Lowest fitness score
  o	The mean fitness score
  o	The current generation of rockets
  o	Which species had the highest fitness score
  o	Which species had the lowest fitness score
The simulation will also be able to display the best, mean and the low fitness score in a graph for each generation.
