### SELECT

- SELECT : 조회하고자 하는 컬럼명을 기술한다. 여러 컬럼을 조회하는 경우 컬럼은 쉼표로 구분하고, 마지막 컬럼 다음은 쉼표를 사용하지 않는다. 모든 컬럼을 조회 시 컬럼명 대신 ‘*’기호로 사용가능하다. 조회 결과는 기술한 컬럼명 순으로 표시된다.
- FROM : 조회 대상 컬럼이 포함된 테이블명을 기술한다.
- WHERE : 행을 선택하는 조건을 기술한다. 여러 개의 제한조건을 포함할 수 있으며,
각각의 제한 조건은 논리 연산자로 연결한다. 제한조건을 만족시키는 행들만 Result Set에 포함한다.

모든 행 모든 컬럼 조회

```sql
--EMPLOYEE 테이블에서 모든 정보 조회
SELECT 
       * 
  FROM EMPLOYEE;
```

원하는 컬럼 조회

```sql
-- EMPLOYEE 테이블의 사번, 이름 조회
SELECT
       EMP_ID
     , EMP_NAME
  FROM EMPLOYEE;
```

원하는 행 조회

```sql
--EMPLOYEE 테이블에서 부서코드가 D9인 사원 조회
SELECT 
       *
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 직급코드가 J1인 사원 조회
SELECT
       *
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J1';
```

원하는 행과 컬럼 조회

```sql
-- EMPLOYEE 테이블에서 급여가 300만원 이상인 사원의
-- 사번, 이름, 부서코드, 급여를 조회하시오
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY >= 3000000
```

컬럼에 별칭 짓기

```sql
-- AS + 별칭을 기술하여 별칭을 지을 수 있다.
SELECT
       EMP_NAME AS 이름
     , SALARY * 12 "1년 급여(원)"
     , (SALARY + (SALARY * BONUS)) * 12  
     , (SALARY + (SALARY * NVL(BONUS, 0))) * 12 AS "총 소득(원)" 
  FROM EMPLOYEE;
```

- 임의로 지정한 문자열을 SELECT절에서 사용할 수 있다

```sql
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , '원' AS 단위
  FROM EMPLOYEE;
```

DISTINCT 키워드는 중복 된 컬럼 값을 제거하여 조회한다.

```sql
SELECT
       DISTINCT JOB_CODE
  FROM EMPLOYEE;

-- DISTINCT 키워드는 SELECT절에 딱 한번만 쓸 수 있다.
-- 여러 개의 컬럼을 묶어서 중복을 제외시킨다.
SELECT
       DISTINCT JOB_CODE
     , /*DISTINCT*/ DEPT_CODE
  FROM EMPLOYEE;
```

WHERE절
테이블에서 조건을 만족하는 값을 가진 행을 골라낸다.
여러 개의 조건을 만족하는 행을 골라 낼 때 AND 혹은 OR를 사용할 수 있다.

```sql
-- 부서코드가 D6이고 급여가 200만원을 초과하여 받는 직원의
-- 이름, 부서코드, 급여 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D6'
   AND SALARY > 2000000;
```

NULL 값 조회

```sql
-- 보너스를 지급받지 않는 사원의
-- 사번, 이름, 급여, 보너스를 조회하세요
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , BONUS
  FROM EMPLOYEE
 WHERE BONUS IS NULL;
```

NULL이 아닌 값 조회

```sql
-- 보너스를 지급받는 사원의
-- 사번, 이름, 급여, 보너스를 조회하세요
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , BONUS
  FROM EMPLOYEE
 WHERE BONUS IS NOT NULL;
```

연결 연산자를 이용하여 여러 컬럼을 하나의 컬럼인 것처럼 연결할 수 있다. (||)

```sql
-- 컬럼과 컬럼 연결
SELECT
       EMP_ID || EMP_NAME || SALARY
  FROM EMPLOYEE;
```

컬럼과 리터럴 연결

```sql
SELECT
       EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.'
  FROM EMPLOYEE;
```

비교 연산자

```sql
-- = 같다, > 크다, < 작다, >= 크거나 같다, <= 작거나 같다  //자바와 다름(==)
-- !=, ^=, <> 같지 않다
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
  FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
 WHERE DEPT_CODE <> 'D9';
```

ex)

```sql
-- EMPLOYEE 테이블에서 퇴사 여부가 N인 직원을 조회하고
-- 근무여부를 별칭으로 하여 재직중이라는 문자열을 결과집합에 포함하여 조회한다.
-- 사번, 이름, 입사일, 근무여부 조회

SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
     , '재직중' 근무여부
  FROM EMPLOYEE
 WHERE ENT_YN = 'N';
```

ex)

```sql
-- EMPLOYEE 테이블에서 급여를 350만원 이상
-- 550만원 이하를 받는 직원의 사번, 이름, 부서코드, 직급코드를 조회하세요
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY >= 3500000
   AND SALARY <= 5500000;
```

BETWEEN AND 사용(NOT)

```sql
-- 컬럼명 BETWEEN 하한값 AND 상한값
-- : 하한값 이상, 상한값 이하의 값
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM EMPLOYEE
 WHERE SALARY BETWEEN 3500000 AND 5500000;

-- 반대로 급여를 350만원 미만, 또는 550만원을 초과하는
-- 직원의 사번, 이름, 부서코드, 급여를 조회하세요
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
-- WHERE NOT SALARY BETWEEN 3500000 AND 5500000;
 WHERE SALARY NOT BETWEEN 3500000 AND 5500000;
-- NOT은 컬럼명 앞에 붙여도 되고 BETWEEN 앞에 붙여도 된다.
```
