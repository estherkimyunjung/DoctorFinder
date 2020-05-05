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
