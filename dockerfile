# Dockerfile

# 공식 Nginx 이미지를 기반으로 합니다.
FROM nginx:1.27.2

# 빌드 시 사용할 환경변수 선언
ARG FRONT_ALB_DNS
ARG BACK_ALB_DNS

# 런타임에서도 사용할 수 있도록 환경변수를 설정
ENV FRONT_ALB_DNS=${FRONT_ALB_DNS}
ENV BACK_ALB_DNS=${BACK_ALB_DNS}

# 작업 디렉토리 설정
WORKDIR /etc/nginx

# 기본 설정 파일 제거
RUN rm /etc/nginx/nginx.conf

# 커스텀 nginx.conf 템플릿 복사
COPY nginx.conf /etc/nginx/nginx.conf

# 커스텀 nginx.conf 템플릿 복사
COPY conf.d/default.conf.template /etc/nginx/conf.d/default.template

# 템플릿 파일에서 환경변수를 치환하여 설정 파일 생성
RUN envsubst '${FRONT_ALB_DNS} ${BACK_ALB_DNS} ${API_GATEWAY_ENDPOINT}' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf

# 포트 노출
EXPOSE 80

# Nginx를 포그라운드에서 실행
CMD ["nginx", "-g", "daemon off;"]
