# Dockerfile

# 공식 Nginx 이미지를 기반으로 합니다.
FROM nginx:1.27.2

# 작업 디렉토리 설정
WORKDIR /etc/nginx

# 기본 설정 파일 제거
RUN rm /etc/nginx/nginx.conf

# 커스텀 nginx.conf 복사
COPY nginx.conf /etc/nginx/nginx.conf

# 사이트별 설정 파일 복사
COPY conf.d/ /etc/nginx/conf.d/

# 필요 시 정적 파일을 복사합니다. 예:
# COPY html/ /usr/share/nginx/html/

# 'envsubst'를 사용하여 환경 변수 치환 및 Nginx 시작
CMD ["/bin/sh", "-c", "envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]

# 포트 노출
EXPOSE 80

# Nginx를 포그라운드에서 실행
# CMD ["nginx", "-g", "daemon off;"]
