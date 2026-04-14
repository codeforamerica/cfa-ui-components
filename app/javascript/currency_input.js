window.formatCurrency = function (value) {
  if (!value) return ""

  let digits = value.replace(/\D/g, "")
  let number = parseInt(digits, 10)

  if (isNaN(number)) return ""

  return (number / 100).toFixed(2)
}
