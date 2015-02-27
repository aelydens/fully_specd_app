require 'rails_helper'

describe Book do


  xit 'it valid with a title, author, and date published' do
    book = Book.create(title: "Modern Macbeth", author: "Will Shakespeare", date: 2006)
    book.valid?
    expect(book).to be_valid
  end

  xit 'is invalid without a title' do
    book = Book.create(author: "Shakespeare")
    book.valid?
    expect(book.errors[:title]).to eq(["can't be blank"])
  end

  xit 'is invalid without an author' do
    book = Book.create(title: "Old Macbeth")
    book.valid?
    expect(book.errors[:author]).to eq(["can't be blank"])
  end

  xit 'is invalid without a date published' do
    book = Book.create(title: "Macbeth", author: "Old Shakespeare")
    book.valid?
    expect(book.errors[:date]).to eq(["can't be blank"])
  end

  xit 'it is valid without a modern date' do
    book = Book.create(title: "The Corrections", author: "Jonathan Franzen", date: 2001)
    book.valid?
    expect(book).to be_valid
  end

  xit 'is invalid if it is not modern (published post 1950)' do
    book = Book.create(title: "Macbeth", author: "Shakespeare", date: 1606)
    book.valid?
    expect(book.errors[:date]).to eq("Please choose a book published after 1950")
  end

end
