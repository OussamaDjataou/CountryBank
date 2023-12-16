FROM java:8-jre

ADD ./build/libs/country_bank-1.0.jar /application/
CMD ["java", "-jar", "/application/country_bank-1.0.jar"]

EXPOSE 8000
