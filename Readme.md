FinancyApp es una aplicación de prueba técnica para manejar transacciones simples (ingresos vs gastos). Utiliza SwiftUI y SwiftData para persistir registros financieros básicos:

• Registro de ingresos/acumulaciones.
• Clasificación por tipo (gastos).
• Resumen interactivo con tarjetas dinámicas.

Perfecta para aprender:
- Bases de SwiftData.
- Computación reactiva en SwiftUI.
- Usuarios puedan crear/modificar transacciones en modo intuitivo.

⸻

Capturas de Pantalla:

![Lista Principal](/imgs/page1.png)
![Agregar Nuevo Item](/imgs/page2.png)
![Detalle de Item](/imgs/page3.png)

⸻

Arquitectura Propuesta
El código actual adopta patrones Swift modernos y estructura típica de prototipos con:
1. SwiftData Modelado:
   • @Model para Record, guardando datos de transacciones con soporte nativo para @Observation (actualizaciones instantáneas).
2. UI Limpia con SwiftUI:
3. • Listado dinámico que actualiza en tiempo real.
4. • Resaltada mediante separadores personalizados, por ejemplo:

Como Probarlo
Prerrequisitos:
1. Necesitas Xcode 15+.
2. Requiere Swift concurrency (@MainActor, async/await) en actualizaciones a los datos de SwiftData.

Instalación/Configuración:
1. Abre el proyecto en Xcode y selecciona tu target (sustituto por ‘FinancyApp’).
2. Usa la herramienta "Add New Files... / Images" para mover estos archivos:
3. Executa (Ctrl + R) y explora el prototipo.
