#---
# Title        : Project -1,
# Subject      : Distributed And Operating Systems Principles
# Team Members : Divy Nidhi Chhibber, Wins Goyal
# File name    :myWorker.ex
#---

defmodule MyWorker do
    @moduledoc """
  This module is executed by the workers. It is called to create the genservers and contains the functions to handle the call and 
  cast calls from the boss.
  """
    use GenServer

    def start_link(n) do
        {:ok,pid} = GenServer.start_link(__MODULE__, [],name: String.to_atom(Integer.to_string(n)) )
        
    end

    def init(state) do
        {:ok, state}
    end
    
    @impl true
    def handle_cast({:message, first , last, ids }, state) do

       value =  MyApp.FindVamp.caller_module(first,last)
       {:noreply, value ++ state }
 
    end 

    
    @impl true
    def handle_call({:result},_from,state) do
        {:reply,state,[]}
    end

    

end