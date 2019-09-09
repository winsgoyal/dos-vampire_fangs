#---
# Title        : Project -1,
# Subject      : Distributed And Operating Systems Principles
# Team Members : Divy Nidhi Chhibber, Wins Goyal
# File name    : findVamp.ex
#---

defmodule MyApp.FindVamp do
    @moduledoc """
  This module is used by the workers to find the vampire numbers and its fangs. It is called when the workers have a cast message 
  with the range to be processsed.
  """
    def caller_module(start, last) do

        Enum.filter(Enum.map(start .. last, fn n -> call_check_vamp(n) end),fn n-> n end)
    end
    def call_check_vamp(num) do
        root = trunc(:math.sqrt(num))
        num_digits = String.length("#{num}")
        num_digits_half=div(num_digits,2)
        
        left = trunc(:math.pow(10,num_digits_half))
        sorted_num= List.to_string(Enum.sort((String.codepoints("#{num}"))))
        left = Kernel.floor (num/left)
        
        ans = find_factors(num,left,root,num_digits, sorted_num, [])
        if(length(ans)==0) do
            :false
        else
            Enum.join([num|ans]," ")
        end
    end


    def find_factors(num, left, right, num_digits, sorted_num, list) when left > right do
        list
    end

    def find_factors(num,left, right, num_digits, sorted_num, list) do  
        divisor=div(num,left)
        is_vamp = (rem((divisor * left),9)== rem((divisor+left),9))
        if(is_vamp) do
            x= String.length("#{left}")== div(num_digits,2)  && String.length("#{divisor}")== div(num_digits,2) 
            y= sorted_num === List.to_string(Enum.sort((String.codepoints("#{left}"<>"#{divisor}")))) 
            z= (rem(left,10)!=0 or rem(divisor,10)!=0) 
            new_list= list ++ [divisor]
            new_list = new_list ++ [left]
            if(((rem(num,left)==0) && (x &&y && z)), do:
                find_factors(num,left+1,right,num_digits, sorted_num,new_list),
            else: find_factors(num,left+1,right,num_digits,sorted_num,list))
        else
            list =find_factors(num,left+1,right,num_digits,sorted_num,list)   
            list    
        end
    end

end