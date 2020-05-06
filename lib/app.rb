$prompt = TTY::Prompt.new(symbols: {marker: '✓'}, active_color: :blue)
@a = Artii::Base.new


def start
    puts @a.asciify("------------------").blue
    puts @a.asciify("Welcome to Doctor Finder!").blue
    puts @a.asciify("------------------").blue
    userInfo
    task_menu 
end 


def search_requirement
    input= $prompt.select('How would you like to search for your doctor?') do |menu|
        menu.choice 'Zip Code', 1
        menu.choice 'Specialty', 2
        menu.choice 'Gender', 3
        menu.choice 'Rating', 4
    end 
    if input == 1
        search_zip_code 
    elsif input == 2
        search_specialty 
    elsif input == 3
        search_gender 
    elsif input ==4 
        search_rating
    end 
end 

def search_gender 
    gender_input= $prompt.select("Please select which gender you would like to search by.") do |menu|
        menu.choice 'Male', 1
        menu.choice 'Female', 2
    end 
    if gender_input == 1
        selection= Doctor.all.where(gender: "Male").all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors are Male. Please choose a doctor to continue:".blue, selection)
        show_doctor_info(view)
    elsif gender_input ==2 
        selection= Doctor.all.where(gender: "Female").all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors are Female. Please choose a doctor to continue:".blue, selection)
        show_doctor_info(view)
        task_menu
    end 
end 

def search_rating 
    rating_input= $prompt.slider('Rating', max: 5, step: 1)
    if rating_input == 0
        rating_input_selection(0) 
    elsif rating_input == 1
        rating_input_selection(1)
    elsif rating_input == 2 
        rating_input_selection(2)
    elsif rating_input == 3
        rating_input_selection(3)
    elsif rating_input == 4
        rating_input_selection(4)
    elsif rating_input == 5
        rating_input_selection(5)
    end 
end 

def rating_input_selection(rating_input_given)
    if Favs_list.all.map do |inst| inst.rating end.include?(rating_input_given.to_i)
        ratings_list = Favs_list.all.where(rating: rating_input_given)
        selection = ratings_list.map do |inst| Doctor.find(inst.doctor_id).name end 
        view = $prompt.select("The following doctors have a rating of #{rating_input_given}. Please choose a doctor to continue:".blue, selection)  
        show_doctor_info(view) 
    else 
        puts "There are no doctors with this rating. Please search for another rating".red 
        search_rating 
    end 
end  

def selection_of_names(search)
selection= search.all.collect do |inst| inst.name end 
end 

def search_zip_code
    zip_code_input= $prompt.ask("Please enter your zip code.")
    if Location.all.map do |inst| inst.zip_code end.include?(zip_code_input.to_i)
        list = Location.all.find_by(zip_code: zip_code_input)
        selection=  Doctor.all.where(location_id: list.id).all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors are located in your zip code. Please choose a doctor to continue:".blue, selection)
        show_doctor_info(view)
    else
        p "There are no matching doctors in your zip code."
        task_menu
    end 
end 

def show_doctor_info(view)
    doctor_instance = Doctor.all.find_by(name: view)
    table = Terminal::Table.new :title => "#{doctor_instance.name}".upcase.yellow, :style => {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
        t << ["Address".upcase.green, "#{doctor_instance.location.address}\n#{doctor_instance.location.city}, #{doctor_instance.location.state} #{doctor_instance.location.zip_code}"]
        t << :separator
        t.add_row ["Specialty".upcase.green, doctor_instance.specialty.name]
        t << :separator 
        t.add_row ["Phone Number".upcase.green, doctor_instance.phone_number]
        t << :separator 
        t.add_row ["Gender".upcase.green, doctor_instance.gender]
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
        selection = selection_of_names(Doctor.all.where(specialty_id: specialty.id))
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
            new_fav_list_view
            # find_fav_list
        elsif input == 3 
            search_requirement 
        elsif input == 4
            delete_fav_list
        elsif input == 5
           puts "Thank you for using Doctor Finder!"
           exit 
        end
end 

