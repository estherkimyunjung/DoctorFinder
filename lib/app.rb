$prompt = TTY::Prompt.new
@a = Artii::Base.new

def start
    puts @a.asciify("Welcome to Doctor Finder!").green
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
            view = $prompt.select("The following doctors are located in your zip code. Please choose a doctor to continue:".green, selection)
            show_doctor_info(view)
    else
        p "There are no matching doctors in your zip code."
        task_menu
    end 
end 

def show_doctor_info(view)
    doctor_instance = Doctor.all.find_by(name: view)
    table = Terminal::Table.new :title => "#{doctor_instance.name}" do |t|
        t << ["Address", "#{doctor_instance.location.address}\n#{doctor_instance.location.city}, #{doctor_instance.location.state} #{doctor_instance.location.zip_code}"]
        t << :separator
        t.add_row ["Specialty", doctor_instance.specialty.name]
        t << :separator 
        t.add_row ["Phone Number", doctor_instance.phone_number]
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
        pediatrics= Specialty.all.find_by(name: "Pediatrics")
        pediatrics_list = Doctor.all.where(specialty_id: pediatrics.id) 
        
        selection= pediatrics_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors practice #{pediatrics.name} medicine. Please choose a doctor to continue:".green, selection)
        show_doctor_info(view)
    
    elsif specialty_input == 2
        internal= Specialty.all.find_by(name: "Internal")
        internal_list = Doctor.all.where(specialty_id: internal.id)

        selection= internal_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors practice #{internal.name} medicine. Please choose a doctor to continue:".green, selection)
        show_doctor_info(view)
            
    elsif specialty_input == 3 
        surgery= Specialty.all.find_by(name: "surgery")
        surgery_list = Doctor.all.where(specialty_id: surgery.id)

        selection= surgery_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors practice #{surgery.name}. Please choose a doctor to continue:".green, selection)
        show_doctor_info(view)

    elsif specialty_input == 4
        family= Specialty.all.find_by(name: "Family Physician")
        family_list = Doctor.all.where(specialty_id: family.id)

        selection= family_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors practice #{family.name} medicine. Please choose a doctor to continue:".green, selection)
        show_doctor_info(view)
        
    elsif specialty_input == 5 
        obgyn= Specialty.all.find_by(name: "Obstetrics")
        obgyn_list = Doctor.all.where(specialty_id: obgyn.id)

        selection= obgyn_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors practice #{obgyn.name} medicine. Please choose a doctor to continue:".green, selection)
        show_doctor_info(view)

    elsif specialty_input == 6
        psych= Specialty.all.find_by(name: "Psychiatry")
        psych_list = Doctor.all.where(specialty_id: psych.id)

        selection= psych_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors practice #{psych.name} medicine. Please choose a doctor to continue:".green, selection)
        show_doctor_info(view)
    end 
end 

def search_specialty_instance(instance, type)
    specialty= Specialty.all.find_by(name: type)
    specialty_list = psych_list = Doctor.all.where(specialty_id: psych.id)
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

