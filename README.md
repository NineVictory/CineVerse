
![image](https://github.com/NineVictory/CineVerse/blob/main/logo.png)
# 프로젝트 이름
> ***Cineverse***
> 
# 프로젝트 기획의도
> 내가 좋아하는 영화 예매와 해당 굿즈들을 한 번에 보고 싶은데?
> 하나로 묶여있는 페이지가 없을까? 라는 질문들에서 시작된 프로젝트

> 이러한 생각들을 모두 해소 시킬 수 있도록,  일반 고객들부터 영화를 주로보는 매니아 개층까지 영화를 예약하는 것 뿐만이 아닌 다양한 컨텐츠를 추가시킨 사이트를 만들기로 하였습니다.
# 프로젝트 소개
> 자신이 보고싶은 영화를 지역별로 예매 할 수 있으며, 자신이 좋아하는 영화의 굿즈도 구매할 수 있는 영화관 사이트입니다.

> 영화예매(좌석선택),영화목록,영화관목록,포인트충전 및 결제, 중고거래,자유게시판,크라우드소싱,마이페이지,문의 등을 제공하는 종합 영화 서비스 플랫폼입니다. 
# 프로젝트 기간
> 2024-06-24 ~ 2024-07-31
>



# 사용 기술
> ## 협업 툴
 >> Google Drive (문서 관리)
> > 
 >> creatie (UI 설계)
> > 
 >> ERD Cloud (DB 설계)
> >
> > canva (PPT 제작)
>## IDE
 >> <img src="https://img.shields.io/badge/Eclipse-2C2255?style=for-the-badge&logo=eclipse&logoColor=white">
> > 
>## 프론트
 >> <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"><br>
> > 
 >> <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"><br>
> > 
 >> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"><br>
> >
 >> <img src="https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white"><br>
> >
 >> <img src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"><br>
> >
 >> <img src="https://img.shields.io/badge/Ajax-0c0d0c?style=for-the-badge&logo=Ajax&logoColor=white"><br>
> > 
 >> <img src="https://img.shields.io/badge/JSP-0c0d0c?style=for-the-badge&logo=JSP&logoColor=white"><br>
> >
>## 백엔드
 >> <img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white"/><br>
> >
 >> <img src="https://img.shields.io/badge/SpringBoot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white"/><br>
> >
 >> <img src="https://img.shields.io/badge/MVC-0c0d0c?style=for-the-badge&logo=MVC&logoColor=white"><br>
> >
 >> <img src="https://img.shields.io/badge/WebSocket-0c0d0c?style=for-the-badge&logo=WebSocket&logoColor=white"><br>
> > 
>## DB
 >><img src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white"> 
> >

# ERD
>
> <div>
>   
 ![image](https://github.com/NineVictory/CineVerse/blob/main/CineVerse%20(1).png)
> </div>

# 트러블슈팅
>   ### 1. 영화 예매 API 응답 속도 문제
>>  * 문제 상황
>> 
>> 초기에 영화 예매 API를 사용하여 지역별 영화 목록을 가져오는 과정에서, 예상보다 응답 속도가 느려 사용자 경험이 저하되는 문제가 발생했습니다. 특히, 특정 시간대에는 요청이 몰리면서 응답 시간이 더 길어졌습니다.
>> 
>>   * 해결 과정
>> 
>>   * API 요청 최적화
>> 
>>   먼저, API 요청을 분석하여 불필요한 데이터 요청이 있는지 확인했습니다. 필요 없는 데이터는 필터링하여 요청을 최소화했습니다.
>>   영화 목록의 기본 정보를 먼저 받아오고, 상세 정보는 별도로 비동기 요청을 통해 받아오는 방식으로 변경하여 초기 로딩 속도를 개선했습니다.
>> 
>>   * 캐싱 적용
>> 
>>   동일한 데이터를 반복적으로 요청하지 않도록, 자주 조회되는 영화 목록은 서버에 캐싱을 적용했습니다. 이를 통해 서버와 API 요청 빈도를 줄여 응답 시간을 개선했습니다.
>> 
>>   * 비동기 처리와 로딩 인디케이터
>> 
>>   비동기 처리를 활용하여 영화 목록이 로드되는 동안 사용자에게 로딩 인디케이터를 표시함으로써 사용자 경험을 향상시켰습니다.
>> 
>>   * 결과
>> 
>>   최종적으로, 응답 시간이 크게 단축되었으며, 사용자는 원활하게 영화를 예매할 수 있게 되었습니다. 캐싱을 통해 트래픽도 효율적으로 관리할 수 있었습니다.

>   ### 2. 좌석 선택 동시성 문제
>>   * 문제 상황
>> 
>>   여러 사용자가 동시에 같은 영화관의 좌석을 선택하는 경우, 동시성 문제가 발생해 좌석 예약이 중복되는 현상이 있었습니다. 이는 특히 인기 영화의 경우 사용자 불만을 초래할 수 있는 치명적인 문제였습니다.
>> 
>>   * 해결 과정
>> 
>>   * 트랜잭션 적용
>>   좌석 선택 로직에 트랜잭션을 적용하여, 같은 좌석에 대해 여러 사용자가 동시에 요청을 보내더라도 하나의 요청만 처리되도록 하였습니다.
>> 
>>   * Optimistic Locking 도입
>>
>>   Optimistic Locking을 도입하여 데이터 충돌을 방지하였고, 충돌이 발생할 경우 사용자에게 이를 안내하는 메시지를 추가하여 부드러운 사용자 경험을 유지했습니다.
>> 
>>   * 좌석 예약 상태 실시간 반영
>> 
>>   WebSocket을 활용하여 다른 사용자가 좌석을 예약했을 때 즉시 좌석 상태가 갱신되도록 하였습니다.
>> 
>>   * 결과
>> 
>>   좌석 선택 시 발생하던 동시성 문제가 완전히 해결되었으며, 사용자는 중복 좌석 선택 없이 안정적으로 예약을 진행할 수 있게 되었습니다.

>   ### 3. 데이터베이스 성능 문제
>>   * 문제 상황
>> 
>>   초기에는 데이터베이스에서 영화, 굿즈, 게시판 등의 데이터를 조회하는 과정에서, 쿼리 실행 시간이 길어져 성능 저하가 발생했습니다.
>> 
>>   * 해결 과정
>> 
>>   * 쿼리 최적화
>> 
>>   주요 쿼리들을 분석하고, 불필요한 서브쿼리를 제거했습니다. 또한, 복잡한 조인을 간소화하고, 인덱스를 적절히 활용하여 성능을 개선했습니다.
>> 
>>   * 데이터베이스 구조 개선
>> 
>>   데이터 정규화를 통해 중복 데이터를 줄이고, 필요한 경우에는 역정규화를 도입하여 조회 성능을 향상시켰습니다.
>> 
>>   * 배치 처리 도입
>> 
>>   대량의 데이터를 처리할 때는 배치 처리를 도입하여 트랜잭션 비용을 줄였습니다.
>> 
>>   * 결과
>> 
>>   데이터베이스 성능이 크게 향상되었으며, 조회 속도가 빨라져 전반적인 사이트 성능과 사용자 경험이 개선되었습니다.

# 회고 / 느낀 점
> 바로 이전 프로젝트 때는 팀의 막내였지만, 이번 프로젝트 때는 팀장 역할을 맡게 되었습니다. 팀장이라는 부담감이 굉장히 크게 다가왔지만
> 이번엔 팀원들도 바뀌었고 대화조차 못해본 새로운 팀원들이 너무 많았기에 어색함을 풀고자 첫만남에 적극적으로 대화를 주도하며 아이스 브레이킹을 시도했습니다.
> 
> 부담이 없다면 거짓말이지만 한 편으로는 설렘으로 가득했습니다. 프로젝트를 시작하기전에 서로의 의견을 무시하지말고 존중하는 것이 가장 중요하다고 말하였고, 서로의 실력차를 존중하며 모르는 것이 있으면 서로 도와주자고 말하였습니다.
> 
> 프로젝트 진행을 하며 어떻게 하면 더 다양하게 공부하고 성장할 수 있을까 함께 고민하였고, 저번 프로젝트에서 진행했던 git-flow 방식이 아닌 GitHub-Flow 방식을 사용하였습니다.
> 또한 깃허브에서 커밋할 때는 서로의 Pull Request를 merge하도록 하여 코드 리뷰를 강제하고, 하루의 프로젝트를 마무리 할 때는 30분~1시간 동안 시간을 내어 서로가 어디까지 진행되고 있는지 화면으로 서로 확인하고 피드백 하는 시간도 가졌습니다.
>
>  아쉬웠던 점중 하나는 프로젝트 개발을 시작하기 전에 화면구현 및 요구사항 정의서 작성을 할 때는 완벽하다고 생각했었습니다.
> 그러나 개발을 진행하는데 있어서 저 뿐만이 아니라 팀원들도 추가하고 싶은 기능들이 생겨났고, 이과정에서 추가적인 회의를 여러번 진행하였습니다.
> 개발 시작 전에 조금 더 완벽하게 구상을 완료하고 시작하였다면 더 좋은 결과를 만들 수 있지않았을까 하는 아쉬움이 있었습니다.
> 
> 팀원들에게 리더십있는 팀장이 되기위해 노력했고, 프로젝트가 끝난 지금 돌이켜보면 모두가 잘 따라와 주었다고 생각합니다.
> 팀원 각자가 자신의 역할을 수행하고 동시에 서로를 지원하며 함께 성장할 수 있는 뜻깊은 경험이었습니다.



> 



# 참여 인원
> * ***구승회(조장)***
> * 박근휘
> * 함종태
> * 최주은
> * 김보미
> * 최민지
> * 박민재
