graph LR
    subgraph Vista (View - Flutter Widgets)
        direction LR
        V_UI[StopwatchView.dart]
        V_DisplayTime[("Mostrar Tiempo Formateado \n (MM:SS:ms)")]
        V_Buttons[("Botones: \n Iniciar/Reanudar, Detener, Reiniciar")]
        V_UserActions[("Capturar Acciones del Usuario \n (toques en botones)")]
    end

    subgraph VistaModelo (ViewModel - Lógica de Presentación)
        direction LR
        VM[StopwatchViewModel.dart]
        VM_State[("Manejar Estado: \n isRunning, canStart, etc.")]
        VM_FormatTime[("Formatear Tiempo \n (desde milisegundos a String)")]
        VM_Actions[("Lógica de Acciones: \n startOrResume(), stop(), reset()")]
        VM_Timer[("Controlar el Timer \n para actualizar el tiempo")]
        VM_Notify[("Notificar Cambios a la Vista \n (usando ChangeNotifier)")]
    end

    subgraph Modelo (Model - Datos y Lógica de Negocio)
        direction LR
        M[StopwatchModel.dart]
        M_Data[("Datos Crudos: \n milliseconds (int), \n isRunning (bool)")]
        M_Logic[("Lógica de Negocio Simple \n (si la hubiera, aquí es mínima)")]
    end

    %% Conexiones y Flujo de Datos/Eventos

    V_UserActions -- "1. Usuario presiona 'Iniciar'" --> VM_Actions
    V_Buttons -- "Observa (para habilitar/deshabilitar)" --> VM_State
    V_DisplayTime -- "Observa (para actualizarse)" --> VM_FormatTime


    VM_Actions -- "2. Llama a startOrResume()" --> VM_Timer
    VM_Timer -- "3. Actualiza milisegundos \n cada 'tick'" --> M_Data
    VM_Actions -- "Actualiza isRunning" --> M_Data

    VM_Actions -- "Modifica estado interno y/o..." --> M_Data
    M_Data -- "Datos actualizados" --> VM[Lee datos del Modelo]

    VM_FormatTime -- "Lee" --> M_Data
    VM_State -- "Determinado por" --> M_Data


    VM -- "4. Llama a notifyListeners()" --> V_UI

    %% Relaciones de dependencia estructural
    V_UI -.->|Depende de (accede vía Provider)| VM
    VM -.->|Depende de (contiene una instancia de)| M


    %% Estilos para claridad (opcional, pero ayuda)
    classDef view fill:#D6EAF8,stroke:#3498DB,stroke-width:2px
    classDef viewModel fill:#D5F5E3,stroke:#2ECC71,stroke-width:2px
    classDef model fill:#FCF3CF,stroke:#F1C40F,stroke-width:2px

    class V_UI,V_DisplayTime,V_Buttons,V_UserActions view
    class VM,VM_State,VM_FormatTime,VM_Actions,VM_Timer,VM_Notify viewModel
    class M,M_Data,M_Logic model