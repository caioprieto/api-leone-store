# API Leone

* Ruby ruby 2.7.6p219
* Rails 7.0.8.6
* PostgreSQL
* Front-end Desacoplado em React
* Gems Principais: Rspec, Puma, StateMachine, ActiveModelSerializers, JWT, Redis, Sidekiq
* Calcular CEP, Calcular Frete, Integração com o ERP da Olist Tiny, API de pagamento

# Subir o server: http://localhost:3000
   - docker-compose run --service-ports app rails server -b 0.0.0.0
# Subir console:
   - docker-compose run app rails c
# Subir o sidekiq
   - docker-compose run --rm app bundle exec sidekiq
