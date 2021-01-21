function selectMotCode() {
  const motDescription = document.querySelector('.mot-desc select')
  if(!motDescription) return false
  motDescription.addEventListener('change', (event) => {
    const selectedOption = event.target.options[event.target.selectedIndex]
    const motCode = selectedOption.dataset.motCode
    const reasonCode = document.querySelector('.mot-code')
    reasonCode.value = motCode
  })
}
selectMotCode()
