def calc_string(string)
  # метод, выполняющая подсчет суммы строки (+ / - / пустая строка)
  # выявляем массив чисел из строки
  string_numb = string.split(/[+,-]/).map{|num| num.to_i}
  # выявляем массив знаков препинания
  string_znak = string.split(/[0-9]/).select{|el| el.size > 0}
  result = 0
  string_znak.each_with_index do |znak, index|
    # если первый знак в массиве знаков
    if index == 0
      case znak
      when "+"
        result = string_numb[0] + string_numb[1]
      when "-"
        result = string_numb[0] - string_numb[1]
      end
    else
      case znak
      when "+"
        result += string_numb[index+1]
      when "-"
        result -= string_numb[index+1]
      end
    end
  end
  return result
end

# генерируем массив вариантов расстановки + / - / пустая строка
# их около 4 686 825 шт
a = [
     "", "", "", "", "", "", "", "", "", 
     "+", "+", "+", "+", "+", "+", "+", "+", "+", 
     "-", "-", "-", "-", "-", "-", "-", "-", "-"
    ]
var_arr = a.combination(9).to_a

def combine_string(znak_comb)
  etalon_string = "9876543210".split("") # строка изначальной расстановки
  # инициируем массив, в элементах которого совмещаются строки и 
  # арифметические знаки
  result_string = []
  znak_comb.each_with_index do |znak, index|
    sum = etalon_string[index] + znak
    result_string.push(sum)
    if index == 8
      result_string.push("0")
    end
  end
  return result_string.join
end

counter = 0
# проходимся по массиву арифметических знаков, комбинируем их с цифрами
# эталонной расстановки и суммируем получившуюся строку
var_arr.each do |znack_string|
  combo_string = combine_string(znack_string)
  summa = calc_string(combo_string)
  # если сумма строки = 200, то выводим ее.
  if summa == 200
    puts combo_string
  end
end
