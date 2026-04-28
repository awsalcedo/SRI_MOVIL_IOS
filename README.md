# SRIMOVIL iOS

Aplicación iOS desarrollada con **Swift** y **SwiftUI** para ofrecer servicios móviles del SRI, siguiendo una arquitectura modular, mantenible, testeable y alineada con buenas prácticas del ecosistema Apple.

El proyecto adopta una arquitectura basada en **MVVM + Clean Architecture**, organizada por funcionalidades (`Features`) y apoyada en capas bien definidas: `Presentation`, `Domain`, `Data` y `Core`.

Además, la capa visual se diseña siguiendo las **Human Interface Guidelines de Apple**, priorizando componentes nativos, consistencia visual, accesibilidad, claridad y una experiencia de usuario coherente con iOS.

---

## Tabla de contenido

- [Objetivo del proyecto](#objetivo-del-proyecto)
- [Principios de arquitectura](#principios-de-arquitectura)
- [Arquitectura general](#arquitectura-general)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Estructura por feature](#estructura-por-feature)
- [Flujo de dependencias](#flujo-de-dependencias)
- [Capas de la arquitectura](#capas-de-la-arquitectura)
- [Core/Services: networking centralizado](#coreservices-networking-centralizado)
- [Repository](#repository)
- [UseCase](#usecase)
- [DataSource](#datasource)
- [DTO](#dto)
- [Mapper](#mapper)
- [Decisiones técnicas](#decisiones-técnicas)
- [Manejo de estado](#manejo-de-estado)
- [Inyección de dependencias](#inyección-de-dependencias)
- [Human Interface Guidelines](#human-interface-guidelines)
- [Convenciones de nombres](#convenciones-de-nombres)
- [Reglas de dependencia](#reglas-de-dependencia)
- [Testing](#testing)
- [Estrategia de migración por feature](#estrategia-de-migración-por-feature)
- [Checklist para nuevas features](#checklist-para-nuevas-features)
- [Resumen](#resumen)

---

## Objetivo del proyecto

SRIMOVIL iOS busca ofrecer una aplicación móvil nativa, estable y mantenible para consultar servicios del SRI desde dispositivos iOS.

Los objetivos técnicos principales son:

- Separar responsabilidades entre UI, lógica de negocio, acceso a datos y networking.
- Mantener una arquitectura escalable por funcionalidad.
- Reducir el acoplamiento entre capas.
- Facilitar pruebas unitarias mediante protocolos e inyección de dependencias.
- Centralizar el networking para evitar duplicación de lógica HTTP.
- Aislar los contratos remotos mediante DTOs.
- Transformar datos externos en modelos propios de dominio.
- Mantener una interfaz visual coherente con las Human Interface Guidelines de Apple.

---

## Principios de arquitectura

El proyecto se basa en los siguientes principios:

1. **Separación de responsabilidades**  
   Cada capa tiene un propósito claro y no invade responsabilidades de otra capa.

2. **Dependencias hacia abstracciones**  
   Los ViewModels dependen de protocolos de casos de uso, y los casos de uso dependen de protocolos de repositorios.

3. **Dominio independiente**  
   La capa `Domain` no debe depender de detalles técnicos como `URLSession`, DTOs, SwiftUI, almacenamiento local o servicios HTTP.

4. **Data encapsula detalles externos**  
   La capa `Data` conoce DTOs, mappers, data sources y servicios remotos.

5. **Core centraliza capacidades transversales**  
   Networking, errores comunes, seguridad, extensiones, constantes y componentes reutilizables deben vivir fuera de las features.

6. **UI nativa y accesible**  
   Las vistas deben usar componentes SwiftUI nativos siempre que sea posible y respetar lineamientos de diseño de Apple.

---

## Arquitectura general

El proyecto utiliza:

```text
SwiftUI + MVVM + Clean Architecture + Repository + UseCase + Mapper
```

Flujo conceptual:

```text
View
↓
ViewModel
↓
UseCaseProtocol
↓
UseCase
↓
RepositoryProtocol
↓
Repository
↓
RemoteDataSource / LocalDataSource
↓
NetworkServiceProtocol
↓
NetworkService
↓
DTO
↓
Mapper
↓
Domain Model
```

Ejemplo aplicado a la feature `Banner`:

```text
BannerHeroView
↓
BannerViewModel
↓
ObtenerBannerUseCaseProtocol
↓
ObtenerBannerUseCase
↓
BannerRepositoryProtocol
↓
BannerRepository
↓
BannerRemoteDataSourceProtocol
↓
BannerRemoteDataSource
↓
NetworkServiceProtocol
↓
BannerDto
↓
BannerMapper
↓
BannerModel
```

---

## Estructura del proyecto

Estructura base recomendada:

```text
SriMovil/
├── App/
├── Core/
├── Features/
├── Root/
├── Components/
└── Assets.xcassets/
```

Descripción general:

- `App/`: punto de entrada de la aplicación y configuración inicial.
- `Core/`: capacidades transversales reutilizables por todas las features.
- `Features/`: módulos funcionales de la aplicación.
- `Root/`: composición principal de navegación o arranque de la app.
- `Components/`: componentes visuales reutilizables cuando no pertenecen exclusivamente a una feature.

---

## Estructura por feature

Cada feature debe organizarse en tres capas principales:

```text
Features/
└── FeatureName/
    ├── Data/
    ├── Domain/
    └── Presentation/
```

Estructura detallada recomendada:

```text
Features/
└── FeatureName/
    ├── Data/
    │   ├── DTOs/
    │   ├── Mappers/
    │   ├── Remote/
    │   ├── Local/
    │   └── Repositories/
    │
    ├── Domain/
    │   ├── Models/
    │   ├── Repositories/
    │   └── UseCases/
    │
    └── Presentation/
        ├── ViewModel/
        └── Views/
```

Ejemplo con `Banner`:

```text
Features/
└── Banner/
    ├── Data/
    │   ├── DTOs/
    │   │   └── BannerDto.swift
    │   ├── Mappers/
    │   │   └── BannerMapper.swift
    │   ├── Remote/
    │   │   ├── BannerRemoteDataSource.swift
    │   │   └── BannerRemoteDataSourceProtocol.swift
    │   └── Repositories/
    │       └── BannerRepository.swift
    │
    ├── Domain/
    │   ├── Models/
    │   │   └── BannerModel.swift
    │   ├── Repositories/
    │   │   └── BannerRepositoryProtocol.swift
    │   └── UseCases/
    │       ├── ObtenerBannerUseCase.swift
    │       └── ObtenerBannerUseCaseProtocol.swift
    │
    └── Presentation/
        ├── ViewModel/
        │   ├── BannerViewModel.swift
        │   └── BannerViewModelProtocol.swift
        └── Views/
            └── BannerHeroView.swift
```

---

## Flujo de dependencias

La aplicación debe mantener un flujo claro:

```text
Presentation → Domain
Data → Domain
Data → Core
```

La capa `Domain` debe mantenerse independiente:

```text
Domain ❌ no depende de Presentation
Domain ❌ no depende de Data
Domain ❌ no depende de Core/Services
Domain ❌ no depende de SwiftUI
Domain ❌ no depende de DTOs
Domain ❌ no depende de URLSession
```

---

## Capas de la arquitectura

### Presentation

La capa `Presentation` contiene vistas SwiftUI y ViewModels.

Responsabilidades:

- Mostrar la interfaz de usuario.
- Observar y renderizar estados.
- Capturar acciones del usuario.
- Invocar métodos del ViewModel.
- No ejecutar lógica de negocio directamente.
- No consumir servicios HTTP directamente.
- No conocer DTOs.
- No decidir de dónde vienen los datos.

Elementos típicos:

```text
Presentation/
├── ViewModel/
└── Views/
```

Ejemplo:

```swift
@Observable
@MainActor
final class BannerViewModel: BannerViewModelProtocol {

    @ObservationIgnored
    private let obtenerBannerUseCase: ObtenerBannerUseCaseProtocol

    var state: ViewState<BannerModel> = .idle

    init(obtenerBannerUseCase: ObtenerBannerUseCaseProtocol = ObtenerBannerUseCase()) {
        self.obtenerBannerUseCase = obtenerBannerUseCase
    }

    func obtenerBanner() async {
        state = .loading

        do {
            let banner = try await obtenerBannerUseCase.execute()
            state = .success(banner)
        } catch {
            state = mapErrorToState(error)
        }
    }
}
```

Los ViewModels pueden transformar errores técnicos en mensajes entendibles para la UI, pero no deben contener lógica de acceso a datos.

### Domain

La capa `Domain` contiene el núcleo funcional de cada feature.

Responsabilidades:

- Definir modelos de dominio.
- Definir protocolos de repositorios.
- Definir casos de uso.
- Representar reglas o acciones de negocio.
- Mantenerse independiente de frameworks externos.
- No conocer DTOs.
- No conocer `NetworkService`.
- No conocer SwiftUI.

Estructura típica:

```text
Domain/
├── Models/
├── Repositories/
└── UseCases/
```

Ejemplo de modelo:

```swift
struct BannerModel: Hashable, Sendable {
    let imagen64: String
    let url: String
    let predeterminado: Bool
}
```

Ejemplo de repositorio como contrato:

```swift
protocol BannerRepositoryProtocol: Sendable {
    func obtenerBanner() async throws -> BannerModel
}
```

Ejemplo de caso de uso:

```swift
protocol ObtenerBannerUseCaseProtocol: Sendable {
    func execute() async throws -> BannerModel
}

final class ObtenerBannerUseCase: ObtenerBannerUseCaseProtocol {
    private let repository: BannerRepositoryProtocol

    init(repository: BannerRepositoryProtocol = BannerRepository()) {
        self.repository = repository
    }

    func execute() async throws -> BannerModel {
        try await repository.obtenerBanner()
    }
}
```

### Data

La capa `Data` contiene implementaciones concretas relacionadas con obtención, transformación y persistencia de datos.

Responsabilidades:

- Implementar repositorios definidos en `Domain`.
- Consumir fuentes remotas.
- Consumir fuentes locales cuando aplique.
- Definir DTOs.
- Definir mappers.
- Transformar DTOs a modelos de dominio.
- Encapsular detalles técnicos de acceso a datos.

Estructura típica:

```text
Data/
├── DTOs/
├── Mappers/
├── Remote/
├── Local/
└── Repositories/
```

Ejemplo:

```swift
final class BannerRepository: BannerRepositoryProtocol {
    private let remoteDataSource: BannerRemoteDataSourceProtocol

    init(remoteDataSource: BannerRemoteDataSourceProtocol = BannerRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }

    func obtenerBanner() async throws -> BannerModel {
        let dto = try await remoteDataSource.obtenerBanner()
        return BannerMapper.toDomain(dto)
    }
}
```

### Core

La capa `Core` contiene elementos transversales que pueden ser usados por múltiples features.

Ejemplos:

```text
Core/
├── Services/
├── State/
├── Security/
├── Extensions/
├── Constants/
├── DesignSystem/
└── Logging/
```

Responsabilidades:

- Centralizar servicios comunes.
- Exponer protocolos reutilizables.
- Contener errores globales.
- Contener utilidades compartidas.
- Evitar duplicación entre features.
- No contener lógica específica de una feature.

---

## Core/Services: networking centralizado

`Core/Services` corresponde a la capa centralizada de networking.

Esta capa encapsula la comunicación HTTP de la aplicación para evitar que cada feature implemente su propio manejo de red.

### Objetivos

- Centralizar llamadas HTTP.
- Construir requests de forma consistente.
- Decodificar respuestas.
- Manejar errores HTTP.
- Manejar autenticación cuando corresponda.
- Reutilizar configuración común.
- Facilitar pruebas mediante protocolos.
- Evitar que las features dependan directamente de `URLSession`.

### Estructura recomendada

```text
Core/
└── Services/
    ├── NetworkService.swift
    ├── Protocols/
    │   └── NetworkServiceProtocol.swift
    ├── Errors/
    │   └── NetworkError.swift
    ├── Auth/
    │   └── AuthType.swift
    └── Endpoints/
        └── Endpoint.swift
```

### Responsabilidad de `NetworkServiceProtocol`

Define el contrato de comunicación HTTP que pueden usar los DataSources.

Ejemplo conceptual:

```swift
protocol NetworkServiceProtocol: Sendable {
    func get<T: Decodable & Sendable>(url: Endpoint) async throws -> T
    func post<T: Decodable & Sendable, Body: Encodable & Sendable>(
        url: Endpoint,
        body: Body
    ) async throws -> T
}
```

### Responsabilidad de `NetworkService`

Implementa el contrato usando `URLSession`.

Responsabilidades:

- Crear `URLRequest`.
- Configurar método HTTP.
- Agregar headers.
- Aplicar autenticación.
- Ejecutar la petición.
- Validar `HTTPURLResponse`.
- Decodificar JSON.
- Mapear errores técnicos a `NetworkError`.

### Responsabilidad de `NetworkError`

Representa errores comunes de red de forma controlada.

Ejemplo:

```swift
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case badRequest
    case unauthorized
    case notFound
    case notAcceptable
    case validateError
    case serverError
    case unknown
}
```

### Regla principal

Las features no deben usar `URLSession` directamente.

Correcto:

```text
BannerRemoteDataSource
↓
NetworkServiceProtocol
↓
NetworkService
↓
URLSession
```

Incorrecto:

```text
BannerViewModel
↓
URLSession
```

Incorrecto:

```text
ObtenerBannerUseCase
↓
NetworkService
```

El networking pertenece a `Core/Services`, pero debe ser consumido desde `Data/Remote`.

---

## Repository

El repositorio es el punto de entrada de la capa `Data` hacia el dominio.

Responsabilidades:

- Implementar un protocolo definido en `Domain`.
- Coordinar fuentes remotas y locales.
- Ocultar detalles de persistencia o red.
- Retornar modelos de dominio.
- Nunca exponer DTOs a Presentation o Domain.
- Usar mappers para transformar datos externos.

Ejemplo:

```swift
protocol BannerRepositoryProtocol: Sendable {
    func obtenerBanner() async throws -> BannerModel
}
```

```swift
final class BannerRepository: BannerRepositoryProtocol {
    private let remoteDataSource: BannerRemoteDataSourceProtocol

    init(remoteDataSource: BannerRemoteDataSourceProtocol = BannerRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }

    func obtenerBanner() async throws -> BannerModel {
        let dto = try await remoteDataSource.obtenerBanner()
        return BannerMapper.toDomain(dto)
    }
}
```

---

## UseCase

El caso de uso representa una acción de negocio concreta.

Ejemplos:

```text
ObtenerBannerUseCase
ConsultarDeudasUseCase
ConsultarEstadoTributarioUseCase
ConsultarMatriculacionVehicularUseCase
```

Responsabilidades:

- Orquestar una acción de negocio.
- Depender de un protocolo de repositorio.
- Retornar modelos de dominio.
- No conocer DTOs.
- No conocer `NetworkService`.
- No conocer SwiftUI.
- No actualizar estado visual.

Ejemplo:

```swift
final class ObtenerBannerUseCase: ObtenerBannerUseCaseProtocol {
    private let repository: BannerRepositoryProtocol

    init(repository: BannerRepositoryProtocol = BannerRepository()) {
        self.repository = repository
    }

    func execute() async throws -> BannerModel {
        try await repository.obtenerBanner()
    }
}
```

---

## DataSource

Un DataSource encapsula el acceso a una fuente concreta de datos.

Puede ser:

```text
RemoteDataSource
LocalDataSource
```

### RemoteDataSource

Responsabilidades:

- Consumir APIs remotas.
- Usar `NetworkServiceProtocol`.
- Retornar DTOs.
- No mapear a modelos de dominio.
- No manejar estado de UI.

Ejemplo:

```swift
protocol BannerRemoteDataSourceProtocol: Sendable {
    func obtenerBanner() async throws -> BannerDto
}

final class BannerRemoteDataSource: BannerRemoteDataSourceProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func obtenerBanner() async throws -> BannerDto {
        try await networkService.get(url: .banner)
    }
}
```

### LocalDataSource

Debe usarse cuando una feature requiera cache, persistencia offline o almacenamiento local.

Responsabilidades:

- Leer/escribir datos locales.
- Encapsular detalles de persistencia.
- Retornar entidades locales o modelos de datos internos.
- No actualizar UI.
- No ejecutar lógica de negocio compleja.

---

## DTO

Los DTOs representan el contrato externo recibido desde una API.

Responsabilidades:

- Decodificar JSON.
- Reflejar fielmente la estructura remota.
- Permanecer en la capa `Data`.
- No contener lógica de negocio.
- No conocer modelos de dominio.
- No conocer SwiftUI.

Ejemplo:

```swift
struct BannerDto: Decodable, Sendable {
    let imagen64: String
    let url: String
    let predeterminado: Bool
}
```

Los DTOs deben ubicarse en:

```text
FeatureName/Data/DTOs/
```

---

## Mapper

El mapper transforma DTOs o entidades de datos en modelos de dominio.

Responsabilidades:

- Convertir objetos externos a modelos internos.
- Centralizar reglas de transformación.
- Evitar que DTOs conozcan el dominio.
- Evitar que repositories contengan lógica repetitiva de conversión.

Ejemplo:

```swift
struct BannerMapper {
    static func toDomain(_ dto: BannerDto) -> BannerModel {
        BannerModel(
            imagen64: dto.imagen64,
            url: dto.url,
            predeterminado: dto.predeterminado
        )
    }
}
```

Ubicación:

```text
FeatureName/Data/Mappers/
```

---

## Decisiones técnicas

### Por qué los ViewModels usan `@MainActor`

Los ViewModels administran estado observable usado directamente por SwiftUI.

Ejemplo:

```swift
@Observable
@MainActor
final class BannerViewModel {
    var state: ViewState<BannerModel> = .idle
}
```

Se usa `@MainActor` porque:

- El estado del ViewModel impacta directamente la UI.
- SwiftUI debe recibir actualizaciones en el actor principal.
- Evita problemas de concurrencia al modificar estado observable.
- Centraliza la seguridad de hilo en la capa de presentación.

### Por qué los UseCases no usan `@MainActor`

Los casos de uso no pertenecen a la UI.

No recomendado:

```swift
@MainActor
protocol ObtenerBannerUseCaseProtocol {
    func execute() async throws -> BannerModel
}
```

Recomendado:

```swift
protocol ObtenerBannerUseCaseProtocol: Sendable {
    func execute() async throws -> BannerModel
}
```

Motivos:

- Un UseCase representa lógica de negocio, no lógica visual.
- Puede ejecutarse desde distintos contextos.
- No debe quedar atado al actor principal.
- Evita propagar restricciones de UI hacia `Domain`.
- Mantiene la capa de dominio independiente y más testeable.

`@MainActor` debe reservarse para componentes que administran estado de UI, como ViewModels.

### Por qué los protocolos usan `Sendable`

`Sendable` se usa en protocolos y modelos que pueden cruzar límites de concurrencia con `async/await`.

Ejemplos:

```swift
protocol ObtenerBannerUseCaseProtocol: Sendable {
    func execute() async throws -> BannerModel
}

protocol BannerRepositoryProtocol: Sendable {
    func obtenerBanner() async throws -> BannerModel
}

protocol BannerRemoteDataSourceProtocol: Sendable {
    func obtenerBanner() async throws -> BannerDto
}
```

Motivos:

- Hace explícito que el contrato puede usarse en contextos concurrentes.
- Ayuda al compilador a detectar riesgos de concurrencia.
- Alinea el diseño con Swift Concurrency.
- Mejora la seguridad al trabajar con operaciones asíncronas.

Criterio general:

```text
ViewModel              → @MainActor
UseCaseProtocol        → Sendable
RepositoryProtocol     → Sendable
DataSourceProtocol     → Sendable
NetworkServiceProtocol → Sendable
DTOs / Models          → Sendable cuando corresponda
```

### Por qué los mappers simples son `struct` y no `final class`

Un mapper simple no necesita identidad ni estado.

Ejemplo:

```swift
struct BannerMapper {
    static func toDomain(_ dto: BannerDto) -> BannerModel {
        BannerModel(
            imagen64: dto.imagen64,
            url: dto.url,
            predeterminado: dto.predeterminado
        )
    }
}
```

Se usa `struct` con métodos `static` porque:

- No mantiene estado interno.
- No requiere ciclo de vida.
- No requiere herencia.
- No necesita inyección de dependencias.
- Representa una transformación pura.
- Evita crear instancias innecesarias.
- Comunica claramente que es una utilidad de conversión.

Criterio técnico:

```text
Mapper sin estado + transformación directa
→ struct con métodos static

Mapper con dependencias o configuración
→ struct instanciable

Mapper con identidad, estado mutable o ciclo de vida
→ final class

class sin final
→ evitar salvo que exista una razón real para permitir herencia
```

No se usa `final class` para un mapper simple porque la semántica de referencia no aporta valor.

### Por qué los DTOs no deben mapearse con extensiones `toDomain`

Aunque esta opción funciona:

```swift
extension BannerDto {
    func toDomain() -> BannerModel {
        BannerModel(
            imagen64: imagen64,
            url: url,
            predeterminado: predeterminado
        )
    }
}
```

No es la opción preferida para este proyecto.

Motivos:

- Acopla el DTO con el modelo de dominio.
- Mezcla contrato remoto con transformación de dominio.
- Hace crecer el DTO con responsabilidades que no le corresponden.
- Dificulta escalar mapeos más complejos.
- Reduce claridad cuando existen múltiples fuentes de datos.

Preferido:

```swift
struct BannerMapper {
    static func toDomain(_ dto: BannerDto) -> BannerModel {
        BannerModel(
            imagen64: dto.imagen64,
            url: dto.url,
            predeterminado: dto.predeterminado
        )
    }
}
```

Regla:

```text
DTO → representa la API
Mapper → transforma
Domain Model → representa la app
```

---

## Manejo de estado

Los ViewModels exponen estado mediante un tipo común como `ViewState`.

Ejemplo conceptual:

```swift
enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case failure(message: String, isInlineFieldError: Bool)
}
```

Objetivos:

- Representar claramente el estado de una pantalla.
- Evitar múltiples flags como `isLoading`, `hasError`, `data`.
- Facilitar renderizado en SwiftUI.
- Unificar carga, éxito y error.
- Permitir mensajes inline o generales.

Ejemplo de uso:

```swift
switch viewModel.state {
case .idle:
    EmptyView()

case .loading:
    ProgressView()

case .success(let banner):
    BannerHeroView(banner: banner)

case .failure(let message, _):
    Text(message)
}
```

---

## Inyección de dependencias

El proyecto usa inyección por inicializador.

Ejemplo:

```swift
final class ObtenerBannerUseCase: ObtenerBannerUseCaseProtocol {
    private let repository: BannerRepositoryProtocol

    init(repository: BannerRepositoryProtocol = BannerRepository()) {
        self.repository = repository
    }
}
```

Beneficios:

- Permite sustituir implementaciones en pruebas.
- Reduce acoplamiento.
- Evita dependencias globales innecesarias.
- Hace explícitas las dependencias de cada tipo.
- Facilita migrar a un contenedor de dependencias si el proyecto crece.

En pruebas, se puede inyectar un mock:

```swift
final class MockBannerRepository: BannerRepositoryProtocol {
    func obtenerBanner() async throws -> BannerModel {
        BannerModel(
            imagen64: "mock",
            url: "https://example.com",
            predeterminado: true
        )
    }
}
```

---

## Human Interface Guidelines

La capa de presentación debe seguir las **Human Interface Guidelines de Apple** para ofrecer una experiencia nativa, clara y consistente.

Criterios aplicados:

- Usar componentes nativos de SwiftUI siempre que sea posible.
- Respetar patrones de navegación propios de iOS.
- Mantener jerarquía visual clara.
- Usar espaciado consistente.
- Evitar interfaces sobrecargadas.
- Respetar Dynamic Type.
- Mantener contraste adecuado.
- Usar colores definidos en Assets o colores semánticos del sistema.
- Evitar tamaños fijos innecesarios cuando afecten accesibilidad.
- Mostrar estados claros de carga, error y contenido vacío.
- Proporcionar feedback visual ante acciones importantes.
- Priorizar legibilidad y consistencia.
- Evitar patrones visuales ajenos a iOS cuando exista una alternativa nativa.

La arquitectura permite que la UI evolucione sin afectar la lógica de negocio ni el acceso a datos.

Ejemplo:

```text
Cambiar el diseño de BannerHeroView
→ no debería modificar UseCase, Repository, DataSource ni NetworkService
```

---

## Convenciones de nombres

### Features

Usar nombres funcionales claros:

```text
Banner
Deudas
EstadoTributario
MatriculacionVehicular
Login
Home
```

### UseCases

Usar verbo + entidad + sufijo `UseCase`:

```text
ObtenerBannerUseCase
ConsultarDeudasUseCase
ConsultarEstadoTributarioUseCase
ConsultarMatriculacionVehicularUseCase
```

### Protocolos

Usar sufijo `Protocol`:

```text
BannerRepositoryProtocol
BannerRemoteDataSourceProtocol
ObtenerBannerUseCaseProtocol
BannerViewModelProtocol
```

### DTOs

Usar sufijo `Dto`:

```text
BannerDto
DeudasDto
EstadoTributarioDto
MatriculacionVehicularDto
```

### Modelos de dominio

Usar nombres representativos del negocio:

```text
BannerModel
DeudasModel
EstadoTributarioModel
MatriculacionVehicularModel
```

### Mappers

Usar entidad + sufijo `Mapper`:

```text
BannerMapper
DeudasMapper
EstadoTributarioMapper
```

---

## Reglas de dependencia

Reglas obligatorias:

```text
View → ViewModel
ViewModel → UseCaseProtocol
UseCase → RepositoryProtocol
Repository → DataSourceProtocol
RemoteDataSource → NetworkServiceProtocol
Repository → Mapper
Mapper → DTO + Domain Model
```

Reglas prohibidas:

```text
View ❌ NetworkService
View ❌ DTO
ViewModel ❌ NetworkService
ViewModel ❌ DTO
UseCase ❌ NetworkService
UseCase ❌ DTO
Domain ❌ Data
Domain ❌ SwiftUI
Domain ❌ URLSession
DTO ❌ ViewModel
DTO ❌ View
```

---

## Testing

La arquitectura facilita pruebas unitarias mediante protocolos.

### Pruebas recomendadas

#### UseCase

Validar que el caso de uso invoque correctamente al repositorio.

```swift
final class MockBannerRepository: BannerRepositoryProtocol {
    var didCallObtenerBanner = false

    func obtenerBanner() async throws -> BannerModel {
        didCallObtenerBanner = true
        return BannerModel(
            imagen64: "mock",
            url: "https://example.com",
            predeterminado: true
        )
    }
}
```

#### ViewModel

Validar transiciones de estado:

```text
idle → loading → success
idle → loading → failure
```

#### Mapper

Validar conversión DTO → Domain Model:

```text
BannerDto.imagen64        → BannerModel.imagen64
BannerDto.url             → BannerModel.url
BannerDto.predeterminado  → BannerModel.predeterminado
```

#### NetworkService

Validar:

- Decodificación correcta.
- Manejo de HTTP 400.
- Manejo de HTTP 401.
- Manejo de HTTP 404.
- Manejo de HTTP 500.
- Manejo de respuesta inválida.
- Manejo de JSON inválido.

---

## Estrategia de migración por feature

La migración hacia esta arquitectura debe hacerse de forma gradual.

Orden recomendado:

```text
1. Banner
2. MatriculacionVehicular
3. EstadoTributario
4. Deudas
5. Login
6. Home
```

Cada migración debe buscar:

- Mantener la app compilando.
- Evitar cambios masivos innecesarios.
- Migrar primero estructura, luego pruebas.
- Eliminar Interactors antiguos cuando el UseCase ya esté conectado.
- Mover DTOs a `Data/DTOs`.
- Mover modelos a `Domain/Models`.
- Mover vistas y ViewModels a `Presentation`.

---

## Checklist para nuevas features

Antes de considerar completa una feature, validar:

```text
[ ] La View no consume NetworkService.
[ ] El ViewModel depende de un UseCaseProtocol.
[ ] El UseCase depende de un RepositoryProtocol.
[ ] El Repository implementa un protocolo de Domain.
[ ] El Repository usa DataSource para acceder a datos.
[ ] El RemoteDataSource usa NetworkServiceProtocol.
[ ] Los DTOs viven en Data/DTOs.
[ ] Los modelos de dominio viven en Domain/Models.
[ ] Existe Mapper cuando hay conversión DTO → Model.
[ ] Domain no importa SwiftUI.
[ ] Domain no conoce DTOs.
[ ] Domain no conoce NetworkService.
[ ] El ViewModel está marcado con @MainActor cuando actualiza estado observable.
[ ] Los protocolos async relevantes usan Sendable.
[ ] La UI respeta patrones nativos de iOS y HIG.
```

---

## Resumen

SRIMOVIL iOS está diseñado con una arquitectura modular basada en:

```text
SwiftUI
MVVM
Clean Architecture
Repository Pattern
UseCase Pattern
Mapper Pattern
Swift Concurrency
Human Interface Guidelines
```

El objetivo es construir una aplicación:

- Mantenible.
- Escalable.
- Testeable.
- Desacoplada.
- Alineada al ecosistema Apple.
- Preparada para evolucionar por features sin comprometer estabilidad.

La regla principal del proyecto es:

```text
La UI presenta.
El ViewModel gestiona estado.
El UseCase ejecuta acciones de negocio.
El Repository coordina datos.
El DataSource obtiene datos.
El NetworkService centraliza HTTP.
El Mapper transforma.
El Domain Model representa la app.
```
