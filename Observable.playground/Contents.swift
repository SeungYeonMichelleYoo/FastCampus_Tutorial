import Foundation
import RxSwift

//Observable 은 여러가지 연산자를 통해서 만든다.
//Observable을 통해서 어떠한 타입의 element를 방출하고 싶은지를 < > 안에 적는다
//just : 오직 하나만 방출하는 Observable sequence를 생성

//Observable: 구독(suscribe)되기 전에는 아무런 이벤트도 내보내지 않는다. Observable자체는 그냥 sequence일 뿐이다.

print("-----Just-----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("----Of1-----") //여러개 방출 가능. element를 각각 방출
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("----Of2-----") //하나의 array를 내뿜음 (just를 쓴거랑 똑같아지는 결과)
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("----from-----") //array만 받는다. array 안의 element들을 하나씩 꺼내서 방출
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("----subscribe1-----") //어떤 이벤트에 쌓여서 오는지 확인시켜줌 (susbscribe를 그대로 쓰는 경우)
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("----subscribe2-----")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("----subscribe3-----") //onNext를 통한 이벤트만 받는다.
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })

print("----empty-----") // 아무런 이벤트 발생 X. 즉시 종료하고 싶거나 의도적으로 0개의 Observable return하고 싶을 때 사용
Observable.empty()
    .subscribe {
        print($0)
    }

print("----empty2-----")
Observable<Void>.empty() //<Void>라고 명시적으로 적는 경우, 타입추론을 하게끔 해준다. 그래서 completed가 위와 달리 출력됨.
    .subscribe {
        print($0)
    }

print("----empty2와 동일한 표현-----")
Observable<Void>.empty()
    .subscribe(onNext: {
        
    },
               onCompleted: {
        print("completed")
    })

print("----never-----")
Observable<Void>.never()
    .debug("never") //이 코드가 작동하는지 알려주는 코드
    .subscribe(
        onNext: {
            print($0)
        },
        onCompleted: {
            print("Completed")
        })

print("----range-----") //start부터 count값만큼 가지게 만들어준다
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0)=\(2*$0)")
    })


print("----dispose-----")
Observable.of(1, 2, 3) //1,2,3을 갖는 Observable을 생성
    .subscribe(onNext: {
        print($0)
    })
    .dispose() //구독 취소

print("----disposebag-----")
let disposeBag = DisposeBag()

Observable.of(1,2,3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag) //먼저 disposeBag에 다 담아놨다가 자신이 할당해제 될 때 모든 Observable들을 구독취소
//왜 이렇게 하는가? 메모리 누수 방지 (만약 일일이 dispose를 하다가 뭔가 빼먹었다면)


print("----create-----")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("------create2------")
enum MyError: Error {
    case anError
}

Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)


print("------deferred1------")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)


print("------deferred2------")
var 뒤집기: Bool = false
let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("👆")
    } else {
        return Observable.of("👇")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
