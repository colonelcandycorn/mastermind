def generate_code
  options = %w[R O Y G B P]
  code = []
  4.times { code.push(options[rand(6)]) }
  p code
end