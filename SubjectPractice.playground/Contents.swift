import RxSwift

var disposeBag = DisposeBag()

print("-------publishSubject-------")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 여러분 안녕하세요") //구독 이전 시점은 전혀 받아들이지 못함

let 구독자1 = publishSubject
    .subscribe(onNext: {
        print("첫번째 구독자: \($0)")
    })

publishSubject.onNext("2. 들리세요?")
publishSubject.onNext("3. 안들리시나요?")

구독자1.dispose()//수동으로 dispose

let 구독자2 = publishSubject
    .subscribe(onNext: {
        print("두번째 구독자: \($0)")
    })

publishSubject.onNext("4. 여보세요")
publishSubject.onCompleted()

publishSubject.onNext("5. 끝났나요")

구독자2.dispose() //수동으로 dispose

//총 5개 이벤트를 방출. 그런데 4번째 이후에 onCompleted. 그래서 5는 출력이 안됨

publishSubject
    .subscribe {
        print("세번째 구독", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

publishSubject.onNext("6. 찍힐까요?") //바라보고 있는 Observable(publishSubject)가 이미 위에서 onCompleted되었기 때문에, 찍히지 않음


print("-------BehaviorSubject-------") //반드시 초깃값을 가진다
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "0. 초기값")

behaviorSubject.onNext("1. 첫번째 값")

behaviorSubject.subscribe {
    print("첫번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

//behaviorSubject.onError(SubjectError.error1)

behaviorSubject.subscribe {
    print("두번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

//구독 바로 직전의 값을 받는 behaviorSubject (구독 전에 가장 최근 값을 같이 emit)

let value = try? behaviorSubject.value()
print(value)


print("------ReplaySubject-------") //구독하기 이전 값들을 버퍼사이즈만큼 방출

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
replaySubject.onNext("1. 여러분")
replaySubject.onNext("2. 힘내세요")
replaySubject.onNext("3. 어렵지만")

replaySubject.subscribe {
    print("첫번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("두번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. 할수있어요")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("세번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)
