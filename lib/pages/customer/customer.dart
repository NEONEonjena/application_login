import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

class CustomerScreen extends StatefulWidget {
  final String username;
  final String password;

  const CustomerScreen({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  CustomerScreenState createState() {
    return CustomerScreenState();
  }
}

class CustomerScreenState extends State<CustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  //Se inicializan los controladores de texto para el formulario
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final List<String> _statusList = ['Activo', 'Inactivo','Bloqueado'];
  String _selectedStatus = 'Activo';
  bool _hasSelectedProfileImage = false;

  @override
  void dispose() {
    // Se limpian los campos del formulario
    _nameController.dispose();
    _lastnameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  //Se crea el método para seleccionar imagen de perfil solo con un icono
  void _toggleProfileImage() {
    setState(() {
      _hasSelectedProfileImage = !_hasSelectedProfileImage;
      if (_hasSelectedProfileImage) {
        if (kDebugMode) {
          print('Foto de perfil seleccionada');
        }
      }
    });
  }

  //Este método debe crearse para manejar el envio del formulario
  void _add() {
    if (_formKey.currentState!.validate()) {
      //Esto muestra los datos en consola para depuración
      if (kDebugMode) {
        print('Nombre: ${_nameController.text}');
        print('Apellido: ${_lastnameController.text}');
        print('Dirección: ${_addressController.text}');
        print('Estado: $_selectedStatus');
        print('Foto de perfil seleccionada: $_hasSelectedProfileImage');
      }

      // Se muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cliente agregado correctamente'),
          backgroundColor: Colors.green,
        ),
      );

      _nameController.clear();
      _lastnameController.clear();
      _addressController.clear();
      setState(() {
        _selectedStatus = 'Activo';
        _hasSelectedProfileImage = false;
      });
    }
  }

  // Este método se encarga de manejar el botón de cancelar
  void _cancel() {
    // Esto permite limpiar los campos del formulario
    _nameController.clear();
    _lastnameController.clear();
    _addressController.clear();
    setState(() {
      _selectedStatus = 'Activo';
      _hasSelectedProfileImage = false;
    });

    // Mensaje de cancelación
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Operación cancelada'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Agregar Cliente', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Para la imagen de perfil se crea un contenedor con un icono de cámara
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _hasSelectedProfileImage
                          ? const AssetImage('assets/img/logos/logo.png')
                          : null,
                      child: _hasSelectedProfileImage
                          ? null
                          : const Icon(Icons.person,
                              size: 60, color: Colors.grey),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: _toggleProfileImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre para el cliente';
                  }
                  if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                    return 'El nombre solo puede tener letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Lastname Field
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un apellido para el cliente';
                  }
                  if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                    return 'El apellido solo puede tener letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Address Field
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una dirección válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Status Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  prefixIcon: Icon(Icons.toggle_on),
                  border: OutlineInputBorder(),
                ),
                value: _selectedStatus,
                items: _statusList.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _add,
                      child: const Text('Agregar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _cancel,
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
