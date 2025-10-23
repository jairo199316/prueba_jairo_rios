#!/bin/zsh
# Script de configuración para Flutter + Gradle en macOS
# Ajusta JAVA_HOME y gradle.properties automáticamente
echo ":llave_de_tuerca: Configurando entorno de desarrollo..."
# 1. Detectar JDK 17 instalado en macOS
JAVA_PATH=$(/usr/libexec/java_home -v 17 2>/dev/null)
if [ -z "$JAVA_PATH" ]; then
  echo ":x: No se encontró un JDK 17 instalado. Instálalo con:"
  echo "   brew install openjdk@17"
  exit 1
fi
# 2. Configurar JAVA_HOME en ~/.zshrc si no existe
if ! grep -q "JAVA_HOME" ~/.zshrc; then
  echo "export JAVA_HOME=$JAVA_PATH" >> ~/.zshrc
  echo ":marca_de_verificación_blanca: JAVA_HOME agregado a ~/.zshrc"
else
  echo ":fuente_de_información: JAVA_HOME ya está configurado en ~/.zshrc"
fi
# 3. Configurar org.gradle.java.home en ~/.gradle/gradle.properties
mkdir -p ~/.gradle
if grep -q "org.gradle.java.home" ~/.gradle/gradle.properties 2>/dev/null; then
  sed -i '' "s|org.gradle.java.home=.*|org.gradle.java.home=$JAVA_PATH|" ~/.gradle/gradle.properties
  echo ":marca_de_verificación_blanca: org.gradle.java.home actualizado en ~/.gradle/gradle.properties"
else
  echo "org.gradle.java.home=$JAVA_PATH" >> ~/.gradle/gradle.properties
  echo ":marca_de_verificación_blanca: org.gradle.java.home agregado a ~/.gradle/gradle.properties"
fi
# 4. Mostrar configuración final
echo "------------------------------------"
echo "JAVA_HOME -> $JAVA_PATH"
echo "Gradle usa -> $(grep org.gradle.java.home ~/.gradle/gradle.properties)"
echo "------------------------------------"
echo ":marca_de_verificación_blanca: Configuración completada. Abre una nueva terminal o corre 'source ~/.zshrc'"