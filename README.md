# Recruitment task for AppUnite Elixir backend developer.

Imagine you are a backend developer entrusted with developing a "Pharmacy" epic.

Pharmacies in this epic don't oparate in an environment of "sell with profit or die", because they are not independent institutions. In this epic by "pharmacy" we mean an in-hospital pharmacy. Such pharmacy should NOT sell drugs to cliens, but rather freely disburse them to the doctors. Such pharmacies have a periodic budgeting they must fit within. Because of that, pharmacies should keep tight grip of how much they are able to purchase from the vendors.

#### The task

You are now entrusted with writing a logic for periodic budget increase for each existing pharmacy. After you're done each pharmacy should has its budget increased by 2500 each day.

#### Notes

* You are free to edit anything in the project.
* Please explicitly tell us when you're done.
* Please don't pay attention to :prod environment. Imagine this is a pre-release project and all production settings are planned for a far future.
* Please test your work, but you don't need to test if a function is run each day. Testing just the function contents is fine.
* Bonus point if you create a pull request (or many pull requests) with your work, but merging to the main is also fine.
* Have a nice day :smiley:!

#### Guide to setup this project
* Working on Windows in NOT recommended.
* Install latest Elixir ([official guide](https://elixir-lang.org/install.html)).
* Install latest PostgreSQL ([official wiki](https://wiki.postgresql.org/wiki/Detailed_installation_guides)).
* Create a Postgres user with all privilages with username: postgres and password: postgres. If you've created user with different credentials you will need to adjust project's `config/dev.exs` and `config/test.exs`.
* Git clone this project.
* Run `mix deps.get`.
* Run `mix ecto.create` and `mix ecto.migrate`.
* Run `MIX_ENV=test mix do ecto.create, ecto.migrate`.
* You have now sucessfully setup the project! :tada:
* You can run tests by invoking `mix test`.
* You can recompile by invoking `mix compile --force`.
* You can run the project in a `:dev` env by invoking `mix phx.server`. With that you will be able to call endpoints hosted on `localhost:4000`.
* If you'd ever need it, there is also `mix ecto.drop` and `mix ecto.rollback`.