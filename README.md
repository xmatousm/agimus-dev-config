# Agimus demos on KUKA robots in RMP laboratory

A docker image is prepared for running the demos. Demo commands are executed
using the script `~/run` inside running docker container. Usually two-computer
setup is needed, the main computer running high-level tasks of a particular demo
and auxiliary computer running the 1kHz controller loop. 

### Starting / running docker containers

On an auxiliary (RT) computer:  

```shell
  cd agimus-dev-config/rt
  # the first/clean run only; create and start the container (if the container
  # exists, it is stopped and deleted first)
  ./x0  
  # or
  ./x1  # starts and enters already created container
```

On a demo computer:

```shell
  cd agimus-dev-config/demo
  ./x0  # the first/clean run only; creates and starts the container
  # or
  ./x1  # starts and enters already created container
```

The following tasks are all run inside the docker container.


### Predefined home position

- run directly on the demo computer
- task `home0` (robot is straight up) to `home3` (robot is bent down)
- workplace selection: `-1` or `-2`
- before running the cardboard demos, robot should be in `home2` position.

`./run -home2 -hw -1`
    

### Cardboard templates

- argument `-x:<template_id>`
- templates for cutting : `1`, `2`, `3`, etc.
- templates for insertion: `B_1`, `B_2`, etc. 


### Launch on aux computer 

- workplace selection: `-1` or `-2`

- `./run aux -hw -1`


### Task 14: Cardboard detection

- on the demo computer
- workplace selection: `-1` or `-2`
- cardboard template selection: `-x:<template_id>`

`./run 14 -hw -1 -x:1`


### Task 15: Cardboard cutting

- on the demo computer, an aux computer should be used: `-use-aux`
- workplace selection: `-2`
- cardboard template selection: `-x:<template_id>`

`./run 15 -hw -use-aux -2 -x:1`


### Task 16: Cardboard insertion
 
- on the demo computer, an aux computer should be used: `-use-aux`
- workplace selection: `-1`
- cardboard template selection: `-x:<template_id>`

`./run 16 -hw -use-aux -1 -x:B_1`