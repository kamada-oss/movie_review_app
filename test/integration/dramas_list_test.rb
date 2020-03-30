require 'test_helper'

class DramasListTest < ActionDispatch::IntegrationTest
  def setup
    @cast1 = casts(:casttest1)
    @cast2 = casts(:casttest2)
    @cast3 = casts(:casttest3)
    @cast4 = casts(:casttest4)
    @cast5 = casts(:casttest5)
    @cast6 = casts(:casttest6)
    @cast7 = casts(:casttest7)
    @cast8 = casts(:casttest8)
    @cast9 = casts(:casttest9)
  end
  
  test "should show now dramas" do
    get dramas_list_now_path
    dramas = Drama.where(status: "放送中")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama)
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
      assert_select "a[href=?]", "/casts/drama/#{@cast1.id}"
      assert_select "a[href=?]", "/casts/drama/#{@cast2.id}"
      assert_select "a[href=?]", "/casts/drama/#{@cast3.id}"
      assert_select "a[href=?]", "/casts/drama/#{@cast4.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast5.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast6.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast7.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast8.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast9.id}", count: 0
    end
    dramas = Drama.where(status: "レンタル予定")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama), count: 0
      assert_select 'h5', text: drama.title, count: 0
    end
    dramas = Drama.where(status: "レンタル")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama), count: 0
      assert_select 'h5', text: drama.title, count: 0
    end
    assert_select "a[href=?]", dramas_list_now_path
    assert_select "a[href=?]", dramas_list_rental_coming_path
    assert_select "a[href=?]", dramas_list_rental_now_path
    #assert_select "a[href=?]", dramas_list_recommended_path
  end
  
  test "should show rental coming dramas" do
    get dramas_list_rental_coming_path
    dramas = Drama.where(status: "放送中")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama), count: 0
      assert_select 'h5', text: drama.title, count: 0
    end
    dramas = Drama.where(status: "レンタル予定")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama)
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
      assert_select "a[href=?]", "/casts/drama/#{@cast1.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast2.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast3.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast4.id}"
      assert_select "a[href=?]", "/casts/drama/#{@cast5.id}"
      assert_select "a[href=?]", "/casts/drama/#{@cast6.id}"
      assert_select "a[href=?]", "/casts/drama/#{@cast7.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast8.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast9.id}", count: 0
    end
    dramas = Drama.where(status: "レンタル")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama), count: 0
      assert_select 'h5', text: drama.title, count: 0
    end
    assert_select "a[href=?]", dramas_list_now_path
    assert_select "a[href=?]", dramas_list_rental_coming_path
    assert_select "a[href=?]", dramas_list_rental_now_path
    #assert_select "a[href=?]", dramas_list_recommended_path
  end
  
  test "should show rental now dramas" do
    get dramas_list_rental_now_path
    dramas = Drama.where(status: "放送中")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama), count: 0
      assert_select 'h5', text: drama.title, count: 0
    end
    dramas = Drama.where(status: "レンタル予定")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama), count: 0
      assert_select 'h5', text: drama.title, count: 0
    end
    dramas = Drama.where(status: "レンタル")
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama)
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
      assert_select "a[href=?]", "/casts/drama/#{@cast1.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast2.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast3.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast4.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast5.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast6.id}", count: 0
      assert_select "a[href=?]", "/casts/drama/#{@cast7.id}"
      assert_select "a[href=?]", "/casts/drama/#{@cast8.id}"
      assert_select "a[href=?]", "/casts/drama/#{@cast9.id}"
    end
    assert_select "a[href=?]", dramas_list_now_path
    assert_select "a[href=?]", dramas_list_rental_coming_path
    assert_select "a[href=?]", dramas_list_rental_now_path
    #assert_select "a[href=?]", dramas_list_recommended_path
  end
  
  
  
  
  
  #yeartest
  test "should show dramas made in 2019 of more" do
    get "/dramas/list/year/2100"
    dramas = Drama.where(release: "2019/01/01".."2019/12/31")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    assert_select "p", text: /2019/, minimum: 1
  end
  
  test "should show dramas made in 2015 " do
    get "/dramas/list/year/2015"
    dramas = Drama.where(release: "2015/01/01".."2015/12/31")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    assert_select "p", text: /2015/, minimum: 1
  end
  
  test "should show dramas made in 1990s " do
    get "/dramas/list/year/1990"
    dramas = Drama.where(release: "1990/01/01".."1999/12/31")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    
  end
  
  test "should show dramas made in 1970s of lower" do
    get "/dramas/list/year/1960"
    dramas = Drama.where(release: "1970/01/01".."1979/12/31")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    
  end
  
  
  
  
  #genretest
  test "should show suspense dramas" do
    get "/dramas/list/genre/suspense"
    dramas = Drama.where(genre: "サスペンス")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/genre/suspense", minimum: 2
    dramas = Drama.where.not(genre:"サスペンス")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}", maximum: 1
    end
  end
  
  test "should show documentary dramas" do
    get "/dramas/list/genre/documentary"
    dramas = Drama.where(genre: "ドキュメンタリー")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/genre/documentary", minimum: 2
    dramas = Drama.where.not(genre:"ドキュメンタリー")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}", maximum: 1
    end
  end
  
  test "should show action dramas" do
    get "/dramas/list/genre/action"
    dramas = Drama.where(genre: "アクション")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/genre/action", minimum: 2
    dramas = Drama.where.not(genre:"アクション")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}", maximum: 1
    end
  end
  
  test "should show SF dramas" do
    get "/dramas/list/genre/SF"
    dramas = Drama.where(genre: "SF")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/genre/SF", minimum: 2
    dramas = Drama.where.not(genre:"SF")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}", maximum: 1
    end
  end
  
  test "should show comedy dramas" do
    get "/dramas/list/genre/comedy"
    dramas = Drama.where(genre: "コメディ")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/genre/comedy", minimum: 2
    dramas = Drama.where.not(genre:"コメディ")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}", maximum: 1
    end
  end
  
  test "should show horror dramas" do
    get "/dramas/list/genre/horror"
    dramas = Drama.where(genre: "ホラー")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/genre/horror", minimum: 2
    dramas = Drama.where.not(genre:"ホラー")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}", maximum: 1
    end
  end
  
  test "should show american dramas" do
    get "/dramas/list/production/america"
    dramas = Drama.where(production: "アメリカ")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/production/america", minimum: 2
    dramas = Drama.where.not(production: "アメリカ")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}", maximum: 1
    end
  end
  
  test "should show english dramas" do
    get "/dramas/list/production/england"
    dramas = Drama.where(production: "イギリス")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/production/england", minimum: 2
    dramas = Drama.where.not(production: "イギリス")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}", maximum: 1
    end
  end
  
  test "should show spanich dramas" do
    get "/dramas/list/production/spain"
    dramas = Drama.where(production: "スペイン")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/production/spain", minimum: 2
    dramas = Drama.where.not(production: "スペイン")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}", maximum: 1
    end
  end
  
  test "should show syrian dramas" do
    get "/dramas/list/production/syria"
    dramas = Drama.where(production: "シリア")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/production/syria", minimum: 2
    dramas = Drama.where.not(production: "シリア")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}", maximum: 1
    end
  end
  
  test "should show canadian dramas" do
    get "/dramas/list/production/canada"
    dramas = Drama.where(production: "カナダ")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/production/canada", minimum: 2
    dramas = Drama.where.not(production: "カナダ")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}", maximum: 1
    end
  end
  
  test "should show french dramas" do
    get "/dramas/list/production/france"
    dramas = Drama.where(production: "フランス")
    dramas.each do |drama|
      assert_select 'h5', text: drama.title
      assert_select "a[href=?]", drama_path(drama)
      assert_select "a[href=?]", "/dramas/list/genre/#{drama.genre_translation}"
    end
    assert_select "a[href=?]", "/dramas/list/production/france", minimum: 2
    dramas = Drama.where.not(production: "フランス")
    dramas.each do |drama|
      assert_select "a[href=?]", "/dramas/list/production/#{drama.production_translation}", maximum: 1
    end
  end
end
