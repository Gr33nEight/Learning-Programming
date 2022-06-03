//
//  LessonViewModel.swift
//  LearningProgramming
//
//  Created by Natanael  on 19/11/2021.
//

import Foundation
import SwiftUI
import Firebase
import Combine


class LevelViewModel : ObservableObject {
    @Published public var levels = [Level]()
    @Published public var didAnswered : Bool = false
    @Published public var isFinished : Bool = false
    @Published public var passedTopics : Int = 0
    
    init(){
        self.fetchData()
    }
    
    func fetchData() {
        Firestore.firestore().collection("Levels").getDocuments { snapshot, error in
            if error == nil {
                for document in snapshot!.documents {
                    let lessons = document.data()["lessons"] as? [String: [String : Any]]
                    let name = document.data()["name"] as? String ?? "error"
                    
                    var lessonsArray = [Lesson]()

                    if let lesson = lessons {
                        for lesson in lesson {
                            let title = lesson.value["title"] as? String ?? "error"
                            let image = lesson.value["image"] as? String ?? "petle"
                            let topicsArray = lesson.value["topicsArray"] as? [String : [String : Any]]

                            var topicsArrayArray = [TopicsArray]()

                            if let topicsArray = topicsArray {
                                for topicsArray in topicsArray {
                                    let topics = topicsArray.value["topics"] as? [String : [String : Any]]
                                    let languageType = topicsArray.value["languageType"] as? String ?? ".cpp"

                                    var topicArray = [Topic]()

                                    if let topics = topics {
                                        for topics in topics {
                                            let question = topics.value["question"] as? String ?? "error"
                                            let code = topics.value["code"] as? String ?? "error"
                                            let correctAnswer = topics.value["correctAnswer"] as? String ?? "error"
                                            let numberOfLines = topics.value["numberOfLines"] as? Int ?? 0
                                            let taskType = topics.value["taskType"] as? String ?? ".abc"
                                            let answers = topics.value["answers"] as? [String : [String : Any]]

                                            var answersArray = [Answer]()

                                            if let answers = answers {
                                                for answers in answers {
                                                    let text = answers.value["text"] as? String ?? "error"

                                                    answersArray.append(Answer(text: text))
                                                }
                                            }
                                            topicArray.append(Topic(question: question, code: code, answers: answersArray, correctAnswer: correctAnswer, numberOfLines: numberOfLines, taskType: TaskType(rawValue: taskType) ?? .explanation))
                                        }
                                    }
                                    topicsArrayArray.append(TopicsArray(topics: topicArray, languageType: LanguageType(rawValue: languageType) ?? .cpp))
                                }
                            }
                            lessonsArray.append(Lesson(title: title, image: image, topicsArray: topicsArrayArray))
                        }
                    }
                    self.levels.append(Level(lessons: lessonsArray, name: name))
                }
            }else {
                print(error!)
            }
        }
        print("liczba leveli \(levels)")
    }
    
    func addData(name: String, image: String, title: String, answer1: String, code1: String, correctAnswer1: String, numberOfLines1: Int, question1: String, taskType1: String, answer2: String, code2: String, correctAnswer2: String, numberOfLines2: Int, question2: String, taskType2: String, answer3: String, code3: String, correctAnswer3: String, numberOfLines3: Int, question3: String, taskType3: String, text: String) {
        let data = ["name" : name,
                    "lessons" : [
                        title : [
                            "image" : image,
                            "title" : title,
                            "topicsArray" : [
                                "cpp" : [
                                    "languageType" : ".cpp",
                                    "topics" : [
                                        question1 : [
                                            "answer" : [
                                                answer1 : [
                                                    "text": text
                                                ]
                                            ],
                                            "code" : code1,
                                            "correctAnswer" : correctAnswer1,
                                            "numberOfLines" : numberOfLines1,
                                            "question" : question1,
                                            "taskType" : taskType1
                                        ]
                                    ]
                                ],
                                "swift" : [
                                    "languageType" : ".swift",
                                    "topics" : [
                                        question2 : [
                                            "answer" : [
                                                answer2 : [
                                                    "text": text
                                                ]
                                            ],
                                            "code" : code2,
                                            "correctAnswer" : correctAnswer2,
                                            "numberOfLines" : numberOfLines2,
                                            "question" : question2,
                                            "taskType" : taskType2
                                        ]
                                    ]
                                ],
                                "python" : [
                                    "languageType" : ".python",
                                    "topics" : [
                                        question3 : [
                                            "answer" : [
                                                answer3 : [
                                                    "text": text
                                                ]
                                            ],
                                            "code" : code3,
                                            "correctAnswer" : correctAnswer3,
                                            "numberOfLines" : numberOfLines3,
                                            "question" : question3,
                                            "taskType" : taskType3
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ] as [String : Any]
        Firestore.firestore().collection("Levels").document(name).setData(data) { _ in
            self.fetchData()
        }
    }
}

        
//TODO LIS
///zrobić żeby poprawne odpowiedzi były arrayem, aby użytkownik mógl wpisać wiele odpowiedzi
///wstecz cofa zrobione zadanie
///można zrobić zrobić żeby odpowiedzi były losowo pokazywane



//class LessonViewModel {
//    @Published public var levels : [Level] = [
//        Level(name: "Łatwy", lessons: [
//            Lesson(title: "Stałe i zmienne", image: "zmienne", topicsArray: [
//                TopicsArray(topics: [
//                    Topic(question: "W programowaniu dane przechowywujemy w stałych lub zmiennych. Zmienna to magazyn danych, która mogą zmieniać swoją wartość w trakcie działania programu. Stała to również magazyn danych lecz jej wartość jest niezmienna. Oznaczona jest jako \"const\". Tak deklarujemy je w c++: ", code:
//                        """
//                        #include <iostream>
//
//                        using namespace std;
//
//                        int main(){
//                            int liczba = 10; // zmienna
//                            string napis = "napis"; // zmienna
//
//                            bool wybór = false; // stała
//                            float pi = 3.14; // stała
//
//                            return 0;
//                        }
//                        """, answers: [], correctAnswer: "", numberOfLines: 13, taskType: .explanation),
//                    Topic(question: """
//                          W języku swift występują różne typy danych:
//                          1. Int - typ liczb całkowitych,
//                          2. Float/Double - typ liczb zmiennoprzecinkowych,
//                          3. Bool - typ logiczny (prawda/fałsz),
//                          4. Char - typ znakowy,
//                          5. String - typ tekstowy.
//                          """, code:
//                          """
//                          #include <iostream>
//
//                          using namespace std;
//
//                          int main(){
//                              int liczba1 = 1; // najpopularniejsze użycie
//
//                              double pi1 = 3.14;
//                              float pi2 = 3.14; // double oraz float można używac naprzemiennie
//
//                              bool wybor1 = false;
//
//                              char znak1 = "R";
//
//                              string napis1 = "napis";
//
//                              return 0;
//                          }
//
//                          """, answers: [], correctAnswer: "", numberOfLines: 18, taskType: .explanation),
//                    Topic(question: "Wpisz odpowiedni typ danych w luce w poniższym kodzie:", code:
//                            """
//                            #include <iostream>
//
//                            using namespace std;
//
//                            int main(){
//
//                                ___________ liczba = 1;
//
//                                return 0;
//                            }
//                            """, answers: [], correctAnswer: "int", numberOfLines: 9, taskType: .writeAnswer),
//                    Topic(question: "Która dana jest typem logiczny:", code: "", answers: [Answer(text: "\"bool\""), Answer(text: "true"), Answer(text: "3")], correctAnswer: "true", numberOfLines: 3, taskType: .abc)
//                ], languageType: .cpp),
//                TopicsArray(topics: [
//                    Topic(question: "W programowaniu dane przechowywujemy w stałych lub zmiennych. Zmienna to magazyn danych, która mogą zmieniać swoją wartość w trakcie działania programu. Oznaczona jest jako \"var\" . Stała to również magazyn danych lecz jej wartość jest niezmienna. Oznaczona jest jako \"let\". Tak deklarujemy je w języku swift: ", code:
//                        """
//                        var liczba: Int = 10 // zmienna
//                        var napis: String = "napis" // zmienna
//
//                        let wybór: Bool = false // stała
//                        let pi: Float = 3.14 // stała
//                        """, answers: [], correctAnswer: "", numberOfLines: 7, taskType: .explanation),
//                    Topic(question: """
//                          W języku swift występują różne typy danych:
//                          1. Int - typ liczb całkowitych,
//                          2. Float/Double - typ liczb zmiennoprzecinkowych,
//                          3. Bool - typ logiczny (prawda/fałsz),
//                          4. Character - typ znakowy,
//                          5. String - typ tekstowy.
//                          """, code:
//                          """
//                          var liczba1 = 1 // najpopularniejsze użycie
//                          var liczba2: Int = 1
//                          var liczba3 = Int(1)
//
//                          var pi1 = 3.14
//                          var pi2: Double = 3.14 // double oraz float można używac naprzemiennie
//                          var pi3 = Float(3.14)
//
//                          var wybor1 = false
//                          var wybor2: Bool = true
//                          var wybor3 = Bool(false)
//
//                          var znak1 = "R"
//                          var znak2: Character = "R"
//                          var znak3 = Character("R")
//
//                          var napis1 = "napis"
//                          var napis2: String = "napis"
//                          var napis3 = String("napis")
//                          """, answers: [], correctAnswer: "", numberOfLines: 18, taskType: .explanation),
//                    Topic(question: "Wpisz odpowiedni typ danych w luce w poniższym kodzie:", code:
//                        """
//                        var liczba: ___________ = 1
//                        """, answers: [], correctAnswer: "Int", numberOfLines: 2, taskType: .writeAnswer),
//                    Topic(question: "Która dana jest typem logiczny:", code: "", answers: [Answer(text: "true"), Answer(text: "\"bool\"") ,Answer(text: "3")], correctAnswer: "true", numberOfLines: 3, taskType: .abc)
//                ], languageType: .swift),
//                TopicsArray(topics: [
//                    Topic(question: "W programowaniu dane przechowywujemy w stałych lub zmiennych. Zmienna to magazyn danych, która mogą zmieniać swoją wartość w trakcie działania programu. Stała to również magazyn danych lecz jej wartość jest niezmienna. W pythonie nie występują stałe. Tak je deklarujemy: ", code:
//                        """
//                        liczba = 10; # zmienna
//                        napis = "napis"; # zmienna
//
//                        wybór = false; # stała
//                        pi = 3.14; # stała
//                        """, answers: [], correctAnswer: "", numberOfLines: 7, taskType: .explanation),
//                    Topic(question:
//                          """
//                          W języku swift występują różne typy danych:
//                          1. Int - typ liczb całkowitych,
//                          2. Float/Double - typ liczb zmiennoprzecinkowych,
//                          3. Bool - typ logiczny (prawda/fałsz),
//                          4. Character - typ znakowy,
//                          5. String - typ tekstowy.
//                          """, code:
//                            """
//                            liczba1 = 1 // najpopularniejsze użycie\n
//                            pi1 = 3.14\n
//                            pi2 = 3.14 // double oraz float można używac naprzemiennie\n
//                            wybor1 = false\n
//                            znak1 = "R"\n
//                            napis1 = "napis"
//                            """, answers: [], correctAnswer: "", numberOfLines: 11, taskType: .explanation),
//                    Topic(question: "Napisz jakiego typu dana jest przedstawiona poniżej", code:
//                        """
//                        wybor = true
//                        """, answers: [], correctAnswer: "bool", numberOfLines: 2, taskType: .writeAnswer),
//                    Topic(question: "Która dana jest typem logiczny:", code: "", answers: [Answer(text: "\"bool\""), Answer(text: "3"), Answer(text: "True")], correctAnswer: "True", numberOfLines: 3, taskType: .abc)
//                ], languageType: .python)
//            ]),
//            Lesson(title: "Pętle", image: "petle", topicsArray: [
//                TopicsArray(topics: [
//                    Topic(question: "W programowaniu dane przechowywujemy w stałych lub zmiennych. Zmienna to magazyn danych, która mogą zmieniać swoją wartość w trakcie działania programu. Stała to również magazyn danych lecz jej wartość jest niezmienna. Oznaczona jest jako \"const\". Tak deklarujemy je w c++: ", code:
//                        """
//                        #include <iostream>
//
//                        using namespace std;
//
//                        int main(){
//                            int liczba = 10; // zmienna
//                            string napis = "napis"; // zmienna
//
//                            bool wybór = false; // stała
//                            float pi = 3.14; // stała
//
//                            return 0;
//                        }
//                        """, answers: [], correctAnswer: "", numberOfLines: 13, taskType: .explanation),
//                    Topic(question: """
//                          W języku swift występują różne typy danych:
//                          1. Int - typ liczb całkowitych,
//                          2. Float/Double - typ liczb zmiennoprzecinkowych,
//                          3. Bool - typ logiczny (prawda/fałsz),
//                          4. Char - typ znakowy,
//                          5. String - typ tekstowy.
//                          """, code:
//                          """
//                          #include <iostream>
//
//                          using namespace std;
//
//                          int main(){
//                              int liczba1 = 1; // najpopularniejsze użycie
//
//                              double pi1 = 3.14;
//                              float pi2 = 3.14; // double oraz float można używac naprzemiennie
//
//                              bool wybor1 = false;
//
//                              char znak1 = "R";
//
//                              string napis1 = "napis";
//
//                              return 0;
//                          }
//
//                          """, answers: [], correctAnswer: "", numberOfLines: 18, taskType: .explanation),
//                    Topic(question: "Wpisz odpowiedni typ danych w luce w poniższym kodzie:", code:
//                            """
//                            #include <iostream>
//
//                            using namespace std;
//
//                            int main(){
//
//                                ___________ liczba = 1;
//
//                                return 0;
//                            }
//                            """, answers: [], correctAnswer: "int", numberOfLines: 9, taskType: .writeAnswer),
//                    Topic(question: "Która dana jest typem logiczny:", code: "", answers: [Answer(text: "\"bool\""), Answer(text: "true"), Answer(text: "3")], correctAnswer: "true", numberOfLines: 3, taskType: .abc)
//                ], languageType: .cpp),
//                TopicsArray(topics: [
//                    Topic(question: "W programowaniu dane przechowywujemy w stałych lub zmiennych. Zmienna to magazyn danych, która mogą zmieniać swoją wartość w trakcie działania programu. Oznaczona jest jako \"var\" . Stała to również magazyn danych lecz jej wartość jest niezmienna. Oznaczona jest jako \"let\". Tak deklarujemy je w języku swift: ", code:
//                        """
//                        var liczba: Int = 10 // zmienna
//                        var napis: String = "napis" // zmienna
//
//                        let wybór: Bool = false // stała
//                        let pi: Float = 3.14 // stała
//                        """, answers: [], correctAnswer: "", numberOfLines: 7, taskType: .explanation),
//                    Topic(question: """
//                          W języku swift występują różne typy danych:
//                          1. Int - typ liczb całkowitych,
//                          2. Float/Double - typ liczb zmiennoprzecinkowych,
//                          3. Bool - typ logiczny (prawda/fałsz),
//                          4. Character - typ znakowy,
//                          5. String - typ tekstowy.
//                          """, code:
//                          """
//                          var liczba1 = 1 // najpopularniejsze użycie
//                          var liczba2: Int = 1
//                          var liczba3 = Int(1)
//
//                          var pi1 = 3.14
//                          var pi2: Double = 3.14 // double oraz float można używac naprzemiennie
//                          var pi3 = Float(3.14)
//
//                          var wybor1 = false
//                          var wybor2: Bool = true
//                          var wybor3 = Bool(false)
//
//                          var znak1 = "R"
//                          var znak2: Character = "R"
//                          var znak3 = Character("R")
//
//                          var napis1 = "napis"
//                          var napis2: String = "napis"
//                          var napis3 = String("napis")
//                          """, answers: [], correctAnswer: "", numberOfLines: 18, taskType: .explanation),
//                    Topic(question: "Wpisz odpowiedni typ danych w luce w poniższym kodzie:", code:
//                        """
//                        var liczba: ___________ = 1
//                        """, answers: [], correctAnswer: "Int", numberOfLines: 2, taskType: .writeAnswer),
//                    Topic(question: "Która dana jest typem logiczny:", code: "", answers: [Answer(text: "true"), Answer(text: "\"bool\"") ,Answer(text: "3")], correctAnswer: "True", numberOfLines: 3, taskType: .abc)
//                ], languageType: .swift),
//                TopicsArray(topics: [
//                    Topic(question: "W programowaniu dane przechowywujemy w stałych lub zmiennych. Zmienna to magazyn danych, która mogą zmieniać swoją wartość w trakcie działania programu. Stała to również magazyn danych lecz jej wartość jest niezmienna. W pythonie nie występują stałe. Tak je deklarujemy: ", code:
//                        """
//                        liczba = 10; # zmienna
//                        napis = "napis"; # zmienna
//
//                        wybór = false; # stała
//                        pi = 3.14; # stała
//                        """, answers: [], correctAnswer: "", numberOfLines: 7, taskType: .explanation),
//                    Topic(question:
//                          """
//                          W języku swift występują różne typy danych:
//                          1. Int - typ liczb całkowitych,
//                          2. Float/Double - typ liczb zmiennoprzecinkowych,
//                          3. Bool - typ logiczny (prawda/fałsz),
//                          4. Character - typ znakowy,
//                          5. String - typ tekstowy.
//                          """, code:
//                            """
//                            liczba1 = 1 // najpopularniejsze użycie\n
//                            pi1 = 3.14\n
//                            pi2 = 3.14 // double oraz float można używac naprzemiennie\n
//                            wybor1 = false\n
//                            znak1 = "R"\n
//                            napis1 = "napis"
//                            """, answers: [], correctAnswer: "", numberOfLines: 11, taskType: .explanation),
//                    Topic(question: "Napisz jakiego typu dana jest przedstawiona poniżej", code:
//                        """
//                        wybor = true
//                        """, answers: [], correctAnswer: "bool", numberOfLines: 2, taskType: .writeAnswer),
//                    Topic(question: "Która dana jest typem logiczny:", code: "", answers: [Answer(text: "\"bool\""), Answer(text: "3"), Answer(text: "True")], correctAnswer: "True", numberOfLines: 3, taskType: .abc)
//                ], languageType: .python)
//            ])
//
//        ]),
//        Level(name: "Średni", lessons: [
//            Lesson(title: "", image: "", topicsArray: [TopicsArray(topics: [Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation),Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation),Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation),Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation),Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation)], languageType: .swift)])
//        ]),
//        Level(name: "Wysoki", lessons: [
//            Lesson(title: "", image: "", topicsArray: [TopicsArray(topics: [Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation),Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation),Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation),Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation),Topic(question: "", code: "", answers: [], correctAnswer: "", numberOfLines: 0, taskType: .explanation)], languageType: .swift)])
//        ])
//    ]
//}
