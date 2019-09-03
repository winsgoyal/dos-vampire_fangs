defmodule MySupervisor do
  use Supervisor

  def start_link([arg1,arg2]) do
    differ = arg2 -arg1
    process_num = div(differ,5000)

    Supervisor.start_link(__MODULE__, arg)
  end

    def init(arg) do
    children = [
      worker(MyWorker, [arg], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

  'def create_range([arg1,arg2]) do
    num_digits_start = String.length(to_string(arg1))
    num_digits_end = String.length(to_string(arg2))-1  
    num_digits_start =   
    if rem(num_digits_start,2) ==0 do
      _num_digits_start = num_digits_start
    else
      _num_digits_start = num_digits_start+1
    end 
    times = num_digits_end - num_digits_start
    num_digits_start = String.to_integer (String.duplicate("9", num_digits_start))
    list = [arg1, num_digits_start]
    create_nine(num_digits_start, times, list)
    
    
  end'

end