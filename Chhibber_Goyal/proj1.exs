#---
# Title        : Project -1,
# Subject      : Distributed And Operating Systems Principles
# Team Members : Divy Nidhi Chhibber, Wins Goyal
# File name    : proj1.exs
#---

args = System.argv
arg1 = String.to_integer (Enum.at(args, 0))
arg2 = String.to_integer (Enum.at(args, 1))


defmodule Start_all do
    @moduledoc """
  This emulates the Boss behavior by creating the supervisor and priting the results
  """
    def start_and_assign(arg1, arg2) do
        MySupervisor.start_link([arg1,arg2])
        task_struct = Enum.map( 1 ..100 , fn x->  Process.whereis(String.to_atom(Integer.to_string(x))) end)
        MyApp.Handle.find_range(task_struct, arg1, arg2)
        print_final(task_struct)
    end

    def print_final(tasks) do
        abc=[]
        abc = for n <- 0 ..99, do: GenServer.call(Enum.at(tasks, n),{:result }, :infinity)
        if(!Enum.empty?(abc)) do      
            IO.puts(Enum.join(List.flatten(abc),"\n"))
        end
    end
end

Start_all.start_and_assign(arg1,arg2)
 
