class CreateBarbers < ActiveRecord::Migration[6.0]
  def change
    create_table :barbers do |t|
      t.text :name
      t.timestamps
    end
    # создаем новые экземпляры класса у которых будут праметры хранится в ввиде хеша
    Barber.create :name => 'Jessie Pinkman'
    Barber.create :name => 'Walter White'
    Barber.create :name => 'Gus Fring'

  end
end
