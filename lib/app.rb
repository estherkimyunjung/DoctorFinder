$prompt = TTY::Prompt.new
@a = Artii::Base.new

# name = prompt.ask("What is your name?")
# p name
# ask = prompt.yes?('Do you like Ruby?')
# p ask
# password = prompt.mask("What is your password?")
# p password

def start
    puts @a.asciify("Welcome to Doctor Finder !").green
    userInfo

    ask = $prompt.yes?('Do you like to find fav_list?')
    p ask
    ask ? find_fav_list : exit

    
    ask = $prompt.yes?('Do you like to add fav_list?')
    p ask
    ask ? add_fav_list : exit
    

    ask = $prompt.yes?('Do you like to delete fav_list?')
    p ask
    ask ? delete_fav_list : exit
    # search_specialty
    
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
        save_doctor(doctor_instance)
    elsif save == 2
        task_menu 
    end 
end 


def save_doctor(doctor)
    # input = $prompt.select ("Would you like to save this doctor to your favorite's list?") do |menu|
    #     menu.choice 'Yes', 1
    #     menu.choice 'No', 2
    # end 
    # if input == 1
    p "Your doctor has been added to your favorite's list."
        # save_to_favs_list(user, doctor) 
    input2 = $prompt.select ("What would you like to do next?") do |menu|
    menu.choice 'See my favorite list?', 1
    menu.choice 'Search for another doctor', 2
    menu.choice 'Exit Doctor Search', 3
    end 
    if input2== 1
        # see_favorite_list 
    elsif input2 == 2
        search_requirement 
    elsif input2 == 3
        "Thank you for using Doctor Search, have a great day!"
    end 
    
end 

def search_specialty
    specialty_input= $prompt.select("What specialty would you like to search for?") do |menu|
        menu.choice 'Pediatrics', 1
        menu.choice 'Internal', 2
        menu.choice 'General', 3
    end 
    if specialty_input == 1
        pediatrics= Specialty.all.find_by(name: "Pediatrics")
        pediatrics_list = Doctor.all.where(specialty_id: pediatrics.id) 
        selection= pediatrics_list.all.collect do |inst| inst.name end 
        view = $prompt.select("The following doctors practice #{pediatrics.name}. Please choose a doctor to continue:".green, selection)
            show_doctor_info(view)
    
    elsif specialty_input == 2
        internal= Specialty.all.find_by(name: "Internal")
        internal_list = Doctor.all.where(specialty_id: internal.id)
        selection= internal_list.all.collect do |inst| inst.name end 
            view = $prompt.select("The following doctors practice #{internal.name}. Please choose a doctor to continue:".green, selection)
                show_doctor_info(view)
            
    elsif specialty_input == 3 
        general= Specialty.all.find_by(name: "General")
        general_list = Doctor.all.where(specialty_id: general.id)
        selection= general_list.all.collect do |inst| inst.name end 
            view = $prompt.select("The following doctors practice #{general.name}. Please choose a doctor to continue:".green, selection)
                show_doctor_info(view)
    end 
end 

# def save_to_favs_list(user, doctor)
#     if Favs_list.all.include?(user)
#         user.favs_list << doctor 
#     else
#         Favs_list.create(user_id: user, doctor_id: doctor)
#         p "A new favorite's list has been created for you."
#         input= $prompt.select do |menu|
#             menu.choice "View Favorite's List", 1
#             menu.choice "Search for another Doctor", 2
#             menu.choice "Exit the app", 3 
#         end 
#         if input == 1 
#             see_favorite_list 
#         elsif input == 2
#             search_requirement 
#         elsif input == 3 
#             p "Thank you for using DocSearch app!"
#         end
#     end  
# end 


def task_menu 
    input= $prompt.select("What would you like to do next?") do |menu|
        menu.choice "View Favorite's List", 1
        menu.choice "Search for another Doctor", 2
        menu.choice "Exit the app", 3 
        end 
        if input == 1 
            see_favorite_list 
        elsif input == 2
            search_requirement 
        elsif input == 3 
            p "Thank you for using DocSearch app!"
        end
end 


# 1. Create User or Check if User exists
#     -If exists, return user name 
#     -load favs_list
#         -all them to add new favorite doctors 
#     -If not, then create new user 
#         -Begin searching for doctors

# 2. Search 
#     -Search by location, or specialty 
#     -Search database based on what user chooses 
#     -return all the matches 

# 3. After searching, user will choose one to update, delete, or add to list. 

# 4. Would you like to search for more options or save your favs list? 

# 5. If save, save the favs list and say "Your list has been saved. Thank you for searching" or else exit "Thanks for searching."
