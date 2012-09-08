class StaticPagesController < ApplicationController
  def home
  end

  def work
  end

  def academic
  end
  
  def skill
  end
  
  def Hobbies
  end
  
  def about
  end
  
  def meecab
    redirect_to "http://www.google.com"
  end
  
end
