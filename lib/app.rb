$prompt = TTY::Prompt.new(symbols: {marker: '✓'}, active_color: :blue)
@a = Artii::Base.new


def start
    puts @a.asciify("Welcome to Doctor Finder!").blue
    userInfo
    task_menu 
end 


def search_requirement
    input= $prompt.select('How would you like to search for your doctor?') do |menu|
        menu.choice 'Zip Code', 1
        menu.choice 'Specialty', 2
    end 
    if input == 1
        search_zip_code 
    elsif input == 2
        search_specialty 
    end 
end 

def search_zip_code
    zip_code_input= $prompt.ask("Please enter your zip code.")
    if Location.all.map do |inst| inst.zip_code end.include?(zip_code_input.to_i)
        list = Location.all.find_by(zip_code: zip_code_input)
        location_list = Doctor.all.where(location_id: list.id)
        
        selection=  location_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors are located in your zip code. Please choose a doctor to continue:".blue, selection)
        show_doctor_info(view)
    else
        p "There are no matching doctors in your zip code."
        task_menu
    end 
end 

def show_doctor_info(view)
    doctor_instance = Doctor.all.find_by(name: view)
    table = Terminal::Table.new :title => "#{doctor_instance.name}".upcase.green, :style => {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
        t << ["Address".upcase.green, "#{doctor_instance.location.address}\n#{doctor_instance.location.city}, #{doctor_instance.location.state} #{doctor_instance.location.zip_code}"]
        t << :separator
        t.add_row ["Specialty".upcase.green, doctor_instance.specialty.name]
        t << :separator 
        t.add_row ["Phone Number".upcase.green, doctor_instance.phone_number]
      end
    puts table 

    save= $prompt.select("Would you like to save this doctor in your favorite's list?") do |menu|
        menu.choice 'Yes', 1
        menu.choice 'No', 2
    end 
    if save == 1 
        add_fav_list(doctor_instance)
    elsif save == 2
        task_menu 
    end 
end 

def search_specialty
    specialty_input= $prompt.select("What specialty would you like to search for?") do |menu|
        menu.choice 'Pediatrics', 1
        menu.choice 'Internal', 2
        menu.choice 'Surgery', 3
        menu.choice 'Family Physician', 4
        menu.choice 'Obstetrics', 5
        menu.choice 'Psychiatry', 6
    end 

    if specialty_input == 1
        search_specialty_instance("Pediatrics")
    elsif specialty_input == 2
        search_specialty_instance("Internal")
    elsif specialty_input == 3 
        search_specialty_instance("surgery")
    elsif specialty_input == 4 
        search_specialty_instance("Family Physician")
    elsif specialty_input == 5 
        search_specialty_instance("Obstetrics")
    elsif specialty_input == 6
        search_specialty_instance("Psychiatry")
end 
end 

def search_specialty_instance(type)
    specialty= Specialty.all.find_by(name: type)
    specialty_list = Doctor.all.where(specialty_id: specialty.id)
    selection= specialty_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors practice #{type} medicine. Please choose a doctor to continue:".blue, selection)
        show_doctor_info(view)
end 

def task_menu 
    input= $prompt.select("What would you like to do next?") do |menu|
        menu.choice "Search for a Doctor", 1
        menu.choice "View Favorite's List", 2
        menu.choice "Add to Favorite's List", 3 
        menu.choice "Delete from Favorite's List", 4
        menu.choice "Exit App", 5
        end 
        if input == 1 
            search_requirement
        elsif input == 2
            find_fav_list
        elsif input == 3 
            search_requirement 
        elsif input == 4
            delete_fav_list
        elsif input == 5
           puts "Thank you for using Doctor Finder!"
           exit 
        end
end 

