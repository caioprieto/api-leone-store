class FreightViewModel
  def initialize(data)
    @freight = data
  end

  def formatted
    return if @freight.blank?

    {
      nome_do_serviço: @freight["name"],
      compania: {
        nome: @freight.dig("company", "name"),
        logo: @freight.dig("company", "picture")
      },
      preço_inicial: @freight["price"].to_f + @freight["discount"].to_f,
      desconto: @freight["discount"].to_f,
      preço_final: @freight["price"].to_f,
      moeda: @freight["currency"],
      tempo_estimado: "#{@freight["delivery_time"]} dias",
      tempo_minimo: "#{@freight.dig("delivery_range", "min")} dias",
      tempo_maximo: "#{@freight.dig("delivery_range", "max")} dias",
    }
  end
end

