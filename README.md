FAAST-Tube
==========

First Weekend Challenge (London Underground).

We have been asked to design the so-called **FAAST* system so that it can be deployed into the London underground network.  This has to be able to cater to the following features:

- There will be a number of trains inside the system.
- Trains will travel from station to station.
- Inside a station, when the train stops, passengers will alight and enter the carriages of the train.
- A Passenger will touch in at the station and touch out at the destination station.
- Each coach of a train can hold up to 40 passengers.
- Each train is made of a number of coaches.
- There is an optional charging system.  Here, passengers can only touch in a station (and access the train) if their account has more than 2 GBP.

###How The System Is Designed
- A Passenger is created.  It has sufficient credit by default, but this can be specified.
- Stations control Passenger entrance, and "allow in" passengers who have credit.
- A Train can arrive and depart from a station.
- When a Train has arrived, Passengers on the train can alight and enter the station, provided that the station is not rammed-full of waiting Passengers.
- When a Train has arrived, Passengers waiting at the station can board the train, provided that the Train is not rammed-full of travelling Passengers.
- The Train can depart from the Station.
- A Passenger that is in a Station can be "released" by that Station in order to exit.

###How I Might Improve This
- Use more doubles
- Classes currently hold too many responsibilities
- The Station "allowing in" Passengers seems a bit counter-intuitive.
- A Coach class has suggested by others
- We learned about the SOLID principles after this has been started
- These would be better deployed in future versions

###Technologies
- Ruby
- RSpec
