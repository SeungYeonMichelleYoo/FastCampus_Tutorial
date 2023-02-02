import RxSwift

let disposeBag = DisposeBag()

print("-----------ignoreElements----------") //next 를 무시. complete나 정지는 허용하지만

let 취침모드😴 = PublishSubject<String>()
취침모드😴
    .ignoreElements()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

취침모드😴.onNext("알람")
취침모드😴.onNext("알람")
취침모드😴.onNext("알람")

취침모드😴.onCompleted()


print("-----------elementAt----------") //n번째 특정 인덱스에 대해서만 방출. 나머지는 무시
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("알람")
두번울면깨는사람.onNext("알람")
두번울면깨는사람.onNext("🍎")
두번울면깨는사람.onNext("알람")


print("-----------filter---------")//filter에서 true인 값만을 방출.
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .filter{ $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----------skip---------")//1번째부터 몇번째까지의 값을 skip할 것인지 적은 다음에 다 스킵하고 그 다음거 방출
Observable.of("1","2","3","4","5","6")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----------skipwhile---------") //skip 하지 않을 때까지 skip을 하다가 종료. 해당 로직이 false 될 때부터 방출 (filter와 반대)
Observable.of("1","2","3","4","5","6","7","8")
    .skip(while: {
        $0 != "5"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----------skipuntil---------")
let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님 //현재 Observable
    .skip(until: 문여는시간) //다른 Observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("🙂")
손님.onNext("🙂")

문여는시간.onNext("땡")
손님.onNext("😎")


print("-----------take---------") //skip과 반대. 내가 표현한 값만큼 출력하고 그 다음부터는 무시
Observable.of("금","은","동","☺️","😎")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----------takewhile---------") //false가 되는 순간 구독 취소. skipwhile과 비슷한 개념이지만 반대로 작용
Observable.of("금","은","동","☺️","😎")
    .take(while: {
        $0 != "동"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----------enumerated---------")
Observable.of("금","은","동","☺️","😎")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----------takeUntil---------") //SkipUntil과 비슷하지만 작용은 반대로
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감) //트리거가 되는 Observable이 구독되기 전까지 방출
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

수강신청.onNext("🙋‍♀️")
수강신청.onNext("🙋‍♀️")

신청마감.onNext("끝!")
수강신청.onNext("🙋‍♀️")

print("-----------distinctUntilChanged---------") //연달아 중복되는걸 1번씩만 방출되게끔 (중복 방지). 그렇지만 뒤에서 다시 "저는"이 나오면 방출됨 (즉 연달아 있는것의 중복을 막는거임)
Observable.of("저는","저는","앵무새","앵무새","앵무새","앵무새","입니다","입니다","입니다","입니다","저는","앵무새","일까요?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
