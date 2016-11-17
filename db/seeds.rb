#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email

category1 = Category.create(name:"Paella")
category2 = Category.create(name:"Traditional food")
category3 = Category.create(name:"Japanese food")
category4 = Category.create(name:"Mexican food")
User.create(name:"David Febrer Cardona",email:"david.febca@gmail.com",rating: 5,
            password:"ironhack",password_confirmation:"ironhack",
            description:"Lorem fistrum de la pradera pecador diodenoo apetecan pecador quietooor apetecan pecador
            sexuarl diodenoo. A peich diodeno por la gloria de mi madre a wan a gramenawer a gramenawer papaar
            papaar torpedo me cago en tus muelas. Amatomaa pupita hasta luego Lucas ese pedazo de diodenoo
            llevame al sircoo al ataquerl diodeno quietooor llevame al sircoo. Tiene musho peligro mamaar sexuarl
            caballo blanco caballo negroorl benemeritaar al ataquerl se calle ustée ese pedazo de jarl. No te
            digo trigo por no llamarte Rodrigor diodeno fistro al ataquerl hasta luego Lucas a peich la caidita
            la caidita. Amatomaa torpedo tiene musho peligro mamaar tiene musho peligro. Diodeno me cago en
            tus muelas me cago en tus muelas jarl me cago en tus muelas.")
