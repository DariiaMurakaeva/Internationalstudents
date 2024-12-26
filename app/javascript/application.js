// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import 'controllers'

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('discussions')
  const dots = document.querySelectorAll('.dot')

  if (container && dots.length > 0) {
    container.addEventListener('scroll', () => {
      const scrollLeft = container.scrollLeft
      const cardWidth = document.querySelector('.discussion').offsetWidth + 16 // Ширина карточки + gap
      const activeIndex = Math.round(scrollLeft / cardWidth)

      dots.forEach((dot, index) => {
        if (index === activeIndex) {
          dot.classList.add('active')
        } else {
          dot.classList.remove('active')
        }
      })
    })
  }
})
