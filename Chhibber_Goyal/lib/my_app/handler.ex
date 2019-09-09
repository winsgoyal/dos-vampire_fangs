#---
# Title        : Project -1,
# Subject      : Distributed And Operating Systems Principles
# Team Members : Divy Nidhi Chhibber, Wins Goyal
# File name    : handler.ex
#---
defmodule MyApp.Handle do
    @moduledoc """
  This module works to create the ranges that have to be assigned to the workers. It then assigns the work and returns. This is 
  executed by the boss module.
  """
    require Integer
    def divide_work(tasks,last,[start_range, end_range], last_task_num) do
        end_range = if(end_range>last, do: last, else: end_range)
        work_total = end_range-start_range
        num_tasks = length(tasks)
        work_each = Kernel.ceil(work_total/num_tasks) +1    
        work_each = if(work_each >5000, do: 5000, else: work_each)
        send_to_work(tasks,start_range, end_range, work_each,last_task_num)
    end

    def send_to_work(tasks,start_range, end_range, work_each, last_task_num) when start_range > end_range do 
       
        last_task_num
    end

    def send_to_work(tasks,start_range, end_range, work_each, last_task_num) when start_range <= end_range do 
        last_task_num =
        cond do
            start_range + work_each <end_range  ->
                send_to_work(tasks,start_range+work_each+1, end_range,work_each, assign_work(tasks, start_range, start_range+ work_each, last_task_num))
            start_range + work_each >= end_range  ->
                send_to_work(tasks,start_range+work_each, end_range,work_each, assign_work(tasks, start_range,end_range, last_task_num))
            end_range-start_range ->
                last_task_num      
        end
        
    end

    def assign_work(tasks, first, last, last_task_num) when last< first do
        last_task_num
    end
    
    def assign_work(tasks, first, last, last_task_num ) do

        GenServer.cast(Enum.at(tasks ,  last_task_num-1  ),{:message, first , last, self() })
        last_task_num = if(last_task_num+1>=length(tasks), do: 0, else: last_task_num+1)
        last_task_num
    end

    def find_range(tasks, first, last) do
        first = if(first <0,do: 0, else: first)
        num_digits_first = String.length("#{first}")
        num_digits_last = String.length("#{last}")
        range_first =if(Integer.is_even(num_digits_first), do: first, else: trunc(:math.pow(10,num_digits_first)))
        last = if(Integer.is_even(num_digits_last), do: last, else: trunc(:math.pow(10,num_digits_last-1)-1))
        
        cond do
            last<range_first  -> 
                nil
            last >= range_first ->
                num_digits_first = String.length("#{range_first}")
                num_digits_last = String.length("#{last}")
                range_list = create_range(num_digits_first, num_digits_last)
                range_list = [range_first] ++ range_list             
                range_list = Enum.map(range_list, fn x-> [x,trunc(:math.pow(10,String.length("#{x}")))-1] end)     
                range_list = Enum.reverse(range_list)
                last_task_num =-1
                Enum.each(range_list, fn range -> last_task_num =  divide_work(tasks, last, range, last_task_num+1) end)                       
        end  
    end

    def create_range(digits_first, digits_last)  when digits_last-digits_first <= 0 do
        []
    end

    def create_range(digits_first,digits_last) do
        range_list =[]
        range_list = for n <- digits_first+2 ..  digits_last, 
            do: if(Integer.is_even(n), do: range_list ++ trunc(:math.pow(10,n-1)))
        range_list= Enum.reject(range_list, &is_nil/1)    
        range_list
    end

end