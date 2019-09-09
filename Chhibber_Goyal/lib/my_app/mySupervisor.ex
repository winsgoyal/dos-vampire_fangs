#---
# Title        : Project -1,
# Subject      : Distributed And Operating Systems Principles
# Team Members : Divy Nidhi Chhibber, Wins Goyal
# File name    : mySupervisor.ex
#---
defmodule MySupervisor do
  @moduledoc """
  This module acts as the supervisor. It creates the children and assigns them to the supervisor.
  """
  use Supervisor

  def start_link([arg1, arg2]) do 
    Supervisor.start_link(__MODULE__,[arg1,arg2])
  end

  def init([arg1, arg2]) do
    
    children = Enum.map(1..100, fn(n) ->
      worker(MyWorker, [n], [id: n, restart: :transient, shutdown: :infinity])
    end)

    supervise(children, strategy: :one_for_one)
  
  end

end
