defmodule Achievement do

  alias Habits.{Account, Habit}
  alias Achievement.{CheckInCount100, CheckInCount1000, CheckInCount10000,
                     HabitCount5, HabitCount10,
                     Streak10}

  def all_for(%Account{} = account) do
    [
      CheckInCount100.for(account),
      CheckInCount1000.for(account),
      CheckInCount10000.for(account),
      HabitCount5.for(account),
      HabitCount10.for(account)
    ]
  end
  def all_for(%Habit{} = habit) do
    [
      CheckInCount100.for(habit),
      CheckInCount1000.for(habit),
      Streak10.for(habit)
    ]
  end
end
