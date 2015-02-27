require 'rails_helper'

feature 'Books' do
  scenario 'User visits the index page and sees all books' do
    visit root_path
    expect(page).to have_content("All Books")
  end

  xscenario 'User creates a new book' do
    visit root_path
    click_on 'New Book'
    click_on 'Create Book'
    expect(page).to have_content("can't be blank")

    fill_in "Title", with: "My Book"
    fill_in "Author", with: "Me"
    fill_in "Date", with: "1966"
    click_on 'Create Book'
    expect(page).to have_content("My Book")
  end

  xscenario 'User edits a book' do
    Book.create(title: "1984", author: "George Orwell")
    visit root_path
    expect(page).to have_content("1984")
    click_on "Edit"
    fill_in "Title", with: "Burmese Days"
    click_on "Update Book"
    expect(page).to have_content("Burmese Days")
  end

  xscenario 'User can visits a book show page by clicking on the title' do
    Book.create(title: "Harry Potter and the Sorcerer's Stone",
               author: "J.K. Rowling")
    click_on "Harry Potter and the Sorcerer's Stone"
    expect(page).to have_content("Book Title:")
  end

  xscenario 'User deletes a book from show page' do
    book = Book.create(title: "Desert Solitaire",
              author: "Edward Abbey")
    visit book_path(book)
    click_on "Delete"
    expect(page).to have_content("All Books")
    expect(page).to have_no_content("Desert Solitaire")
  end
end
