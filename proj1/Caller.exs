args = System.argv()
arg1 = String.to_integer(Enum.at(args,0))
arg2 = String.to_integer(Enum.at(args,1))
MySupervisor.start_link([arg1,arg2])
