require 'rails_helper'

describe BooksController do

  describe 'GET #index' do
    it 'populates an array of all books' do
      book2 = Book.create(title: "Two Fish", author: "Dr. Seuss", date: "1951")
      book = Book.create(title: "One Fish", author: "Dr. Seuss", date: "1951")
      get :index
      expect(assigns(:books)).to match_array([book, book2])
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new Book to @book' do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns requested book to @book" do
      book = Book.create(title: "One Fish", author: "Dr. Seuss", date: "1951")
      get :edit, id: book
      expect(assigns(:book)).to eq(book)
    end

    it 'renders the :edit template' do
      book = Book.create(title: "One Fish", author: "Dr. Seuss", date: "1951")
      get :edit, id: book
      expect(response).to render_template :edit
    end
  end

  describe 'GET #show' do
    it 'assigns requested book to @book' do
      book = Book.create(title: "Title", author: "Author", date: "1951")
      get :show, id: book
      expect(assigns(:book)).to eq(book)
    end

    it 'renders the :show template'
      book = Book.create(title: "Title", author: "Author", date: "1951")
      get :show, id: book
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    before :each do
      @book = Book.create(title: "Title", author: "Author", date: "1951")
      @invalid_book = Book.create(title: nil, author: nil, date: "1951")
    end

    context 'with invalid attributes' do
      it 'does not save the new book in the db' do
        expect{
          post :create, book: attributes_for(@invalid_book)
        }.not_to change(Book, :count)
      end

      it 're-renders the :new template' do
        post :create, book: attributes_for(@invalid_book)
        expect(response).to render_template :new
      end
    end

    context 'with valid attributes' do
      it 'saves the new book in the db' do
        expect{
          post :create, book: attributes_for(@book)
        }.to change(Book, :count).by(1)
      end

      it 'redirects to books#index' do
        post :create, book: attributes_for(@book)
        expect(response).to redirect_to books_path
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @book = Book.create(title: "Castaway", author: "John Smith", date: "1951")
      @invalid_book = Book.create(title: nil, author: nil, date: "1951")
    end

    context 'with invalid attributes' do
      it 'does not update the book' do
        patch :update, id: @book,
          book: attributes_for(@book, title: nil, author: "Bang")
        @book.reload
        expect(@book.title).not_to eq('nil')
        expect(@book.author).to eq ('John Smith')
      end

      it 'rerenders the :edit template' do
        patch :update, id: @book,
          book: attributes_for(@invalid_book)
        expect(response).to render_template :edit
      end
    end

    context 'with valid attributes' do
      it 'locates the right @book' do
        patch :update, id: @book, book: attributes_for(:book)
        expect(assigns(:book)).to eq(@book)
      end

      it 'updates the book in the db' do
        patch :update, id: @book, book: attributes_for(:book, title: "Found", author: "Jane Smith")
        @book.reload
        expect(@book.title).to eq("Found")
        expect(@book.author).to eq("Jane Smith")
      end

      it 'redirects to books#index' do
        patch :update, id: @book, book: attributes_for(:book)
        expect(response).to redirect_to books_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @book = Book.create(title: "Title", author: "Author", date: "1951")
    end

    it 'deletes the book from the db' do
      expect{ delete :destroy, id: @book
      }.to change(Book, :count).by(-1)
    end

    it 'redirects to books#index' do
      delete :destroy, id: @book
      expect(response).to redirect_to books_path
    end
  end

end
