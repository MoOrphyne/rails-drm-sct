const removeRow = () => {
  const btns = document.querySelectorAll('.item-rm')
  btns.forEach((btn) => {
    btn.addEventListener('click', (event) => {
      const row = document.getElementById(`item-row-${btn.id}`)
      row.remove();
    })
  })
}

export { removeRow }
