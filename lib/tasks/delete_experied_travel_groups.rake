namespace :delete do
  desc 'Удаление групп прошедших туров'
  task old_travel_groups: :environment do
    TravelGroup.all.each do |group|
      if group.start_date.to_date < Date.today
        group.delete
      end
    end
  end

  desc 'Удаление пустых городов вылета'
  task blank_departures: :environment do
    Departure.all.each do |d|
      unless d.travel_groups.present?
        d.delete
      end
    end
  end

end