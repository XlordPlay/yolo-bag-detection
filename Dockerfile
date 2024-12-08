# Используем базовый образ Python 3.11
FROM python:3.11-slim

# Установка системных зависимостей для OpenCV
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Создание рабочей директории
WORKDIR /app

# Копирование только файла зависимостей для установки
COPY requirements.txt .

# Установка Python-зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Копирование кода приложения в контейнер
COPY . .

# Создание тома для сохранения видео
VOLUME /app/output

# Запуск скрипта
CMD ["python", "src/main.py"]