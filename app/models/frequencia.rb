# encoding: UTF-8
class Frequencia
  DIARIA = 1
  SEMANAL = 2
  QUINZENAL = 3
  MENSAL = 4
  BIMESTRAL = 5
  TRIMESTRAL = 6
  SEMESTRAL = 7
  ANUAL = 8

  def to_a
    {
      'Diária' => DIARIA,
      'Semanal' => SEMANAL,
      'Quinzenal' => QUINZENAL,
      'Mensal' => MENSAL,
      'Bimestral' => BIMESTRAL,
      'Trimestral' => TRIMESTRAL,
      'Semestral' => SEMESTRAL,
      'Anual' => ANUAL
    }
  end

  def to_times constante
    if constante == DIARIA
      1.days
    elsif constante == SEMANAL
      1.weeks
    elsif constante == QUINZENAL
      15.dias
    elsif constante == MENSAL
      1.months
    elsif constante == BIMESTRAL
      2.months
    elsif constante == TRIMESTRAL
      3.months
    elsif constante == SEMESTRAL
      6.months
    elsif constante == ANUAL
      1.years
    end
  end
end
