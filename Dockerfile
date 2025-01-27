# Usar imagem base do Ruby
FROM ruby:2.7.6

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Configurar diretório de trabalho
WORKDIR /app

# Copiar o Gemfile e instalar gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

ENV RAILS_ENV=production

# Copiar a aplicação
COPY . .

# Expor a porta padrão do Rails
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && rails server -b 0.0.0.0 -p 3000"]
