import 'package:flutter/material.dart';
import 'package:launder_app/presentation/pages/outlet/detail_outlet_page.dart';

class OutletPage extends StatelessWidget {
  const OutletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outlet', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total 10 Outlet', style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),),
              const SizedBox(height: 16,),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOutletPage()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Image.asset('assets/images/logo.jpg', width: 48, height: 48,),
                          title: Text('Outlet ${index + 1}', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                          subtitle: Text('Jalan Semarang ${index + 1}', style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 16,),
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}