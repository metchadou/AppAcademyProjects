# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  Cat.create([
    {
      name: "Garfield",
      birth_date: "2020/02/18",
      sex: "M",
      color: "brown",
      description: "Les aventures mouvementées de Garfield, plus paresseux que jamais et toujours aussi accro aux lasagnes. Le célèbre chat roux a pour acolytes Jon, qui croit être le maître de la maison, et Odie, un chien aussi idiot qu'adorable."
    },
    {
      name: "Djarra",
      birth_date: "2019/05/12",
      sex: "F",
      color: "white",
      description: "Les aventures mouvementées de Djarra, plus paresseux que jamais et toujours aussi accro aux lasagnes. Le célèbre chat roux a pour acolytes Jon, qui croit être le maître de la maison, et Odie, un chien aussi idiot qu'adorable."
    },
    {
      name: "Gizmo",
      birth_date: "2018/12/30",
      sex: "M",
      color: "black",
      description: "Les aventures mouvementées de Gizmo, plus paresseux que jamais et toujours aussi accro aux lasagnes. Le célèbre chat roux a pour acolytes Jon, qui croit être le maître de la maison, et Odie, un chien aussi idiot qu'adorable."
    },
    {
      name: "Petit Chat",
      birth_date: "2015/11/15",
      sex: "M",
      color: "white",
      description: "Les aventures mouvementées de Petit Chat, plus paresseux que jamais et toujours aussi accro aux lasagnes. Le célèbre chat roux a pour acolytes Jon, qui croit être le maître de la maison, et Odie, un chien aussi idiot qu'adorable."
    },
    {
      name: "Chacala",
      birth_date: "2017/07/22",
      sex: "F",
      color: "black",
      description: "Les aventures mouvementées de Chacala, plus paresseux que jamais et toujours aussi accro aux lasagnes. Le célèbre chat roux a pour acolytes Jon, qui croit être le maître de la maison, et Odie, un chien aussi idiot qu'adorable."
    }
  ])
end