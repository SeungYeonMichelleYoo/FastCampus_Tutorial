import RxSwift

let disposeBag = DisposeBag()

print("-------startWith----------")
let 노랑반 = Observable<String>.of("☺️","👧","👦")

노랑반
    .enumerated()
    .map({ index, element in
        element + "어린이" + "\(index)"
    })
    .startWith("👳선생님") //String. startWith 위치에 관계 없이 구독 전에 이게 있다면 이거부터 초기값처럼 붙여주고 그 다음에 element 들이 나옴
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------concat1----------")
let 노랑반어린이들 = Observable<String>.of("☺️","👧","👦")
let 선생님 = Observable<String>.of("👳선생님")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------concat2----------")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------concatMap----------")
let 어린이집: [String: Observable<String>] = [
    "노랑반": Observable.of("☺️","👧","👦"),
    "파랑반": Observable.of("👼","🧚🏻‍♂️")
]
Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


//합치기
print("-------merge1---------")
let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천구"]) //둘중에 하나라도 에러시 아래 구독하다가 즉시 종료

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: { //2개의 Observable을 합쳐서 구독 (섞여서 나옴, 순서보장X)
        print($0)
    })
    .disposed(by: disposeBag)


print("-------merge2---------")
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1) //하나의 Observable의 sequence가 완료되기 전까지 다음 Observable을 읽지 않음. 제한.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------combineLatest1---------")
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }
성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")
이름.onNext("똘똘")
이름.onNext("영수")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")


print("-------combineLatest2---------")
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(
        날짜표시형식,
        현재날짜,
        resultSelector: { 형식, 날짜 -> String in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = 형식
            return dateFormatter.string(from: 날짜)
        }
    )

현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------combineLatest3---------")
let lastName = PublishSubject<String>() //성
let firstName = PublishSubject<String>() //이름

let fullName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lilly")



print("-------Zip---------") //둘 중 하나의 Observable이 완료되면 전체가 완료되어버림 (merge와 차이점)
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .패, .패, .승, .패)
let 선수 = Observable<String>.of("한국","스위스","미국","프랑스","뉴질랜드","가나")

let 시합결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + "\(결과)"
    }

시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------withLatestFrom1---------") //방아쇠 역할(트리거)
let 🔫 = PublishSubject<Void>()
let 달리기선수 = PublishSubject<String>()

🔫
    .withLatestFrom(달리기선수)
    .distinctUntilChanged() //sample과 똑같이 결과가 나오게 하려면 이거 쓰면 됨
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

달리기선수.onNext("⛹️‍♀️")
달리기선수.onNext("⛹️‍♀️  🤺")
달리기선수.onNext("⛹️‍♀️ 🤺 🚴‍♀️")
🔫.onNext(Void())
🔫.onNext(Void())


print("-------sample---------") // withLatestFrom과 비슷하게 작동하지만 한번만 출력된다는게 다름
let 출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(출발)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1선수.onNext("🚗")
F1선수.onNext("🚗 🚙")
F1선수.onNext("🚗 🚙 🚌")
출발.onNext(Void())
출발.onNext(Void())
출발.onNext(Void())


print("-------amb---------") //ambiguous의 약자. 먼저 방출하는 Observable이 생기면, 나머지 Observable에 대해서는 더 이상 구독하지 않음
let bus1 = PublishSubject<String>()
let bus2 = PublishSubject<String>()

let 버스정류장 = bus1.amb(bus2) //버스1, 버스2 지켜보다가 하나 구독시작하면 나머지는 무시

버스정류장
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

bus2.onNext("버스2-승객0")
bus1.onNext("버스1-승객0")
bus1.onNext("버스1-승객1")
bus2.onNext("버스2-승객1")
bus1.onNext("버스1-승객1")
bus2.onNext("버스2-승객2")


print("-------switchLatest---------")//소스Observable(손들기)로 들어온 마지막(최신) Observable만 구독
let 학생1 = PublishSubject<String>()
let 학생2 = PublishSubject<String>()
let 학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()

let 손든사람만말할수있는교실 = 손들기.switchLatest()

손든사람만말할수있는교실
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(학생1)
학생1.onNext("학생1: 저는 1번 학생입니다.")
학생2.onNext("학생2: 저요 저요")

손들기.onNext(학생2)
학생2.onNext("학생2: 저는 2번 학생입니다.")
학생1.onNext("학생1: 저.. 아직 할말 있는데")

손들기.onNext(학생3)
학생2.onNext("학생2: 잠깐만.")
학생1.onNext("학생1: 저는 1번 학생입니다.")
학생3.onNext("학생3: 저는 3번 학생입니다.")

손들기.onNext(학생1)
학생1.onNext("학생1: 저는 1번 학생입니다.")
학생3.onNext("학생3: 저는 3번 학생입니다.")
학생2.onNext("학생2: 저는 2번 학생입니다.")


print("-------reduce---------")
Observable.from((1...10))
//    .reduce(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
//    .reduce(0) { summary, newValue in
//        return summary + newValue
//    })
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------scan---------") //매번 들어올때마다 방출. 리턴값: Observable
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
