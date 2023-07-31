import 'package:flutter/material.dart';
import 'package:provitask_app/models/provider/provider_model.dart';

class ProviderCard extends StatelessWidget {
  final Provider provider;
  const ProviderCard({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProviderSkill> allSkills = provider.allSkills ?? [];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(provider.avatarImage ?? ''),
              ),
              title: Text('${provider.name} ${provider.lastname}'),
              subtitle: Text(
                provider.description ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: const Text(
                'Skills',
              ),
              subtitle: Column(
                children: allSkills.map((skill) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        skill.categoriasSkill,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                          '\$${skill.cost.toString()} ${skill.typePrice == 'by_project_flat_rate' ? '/bpfr' : skill.typePrice == 'per_hour' ? '/hour' : '/ft'}'),
                    ],
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: const Text('Availability'),
              subtitle: Text(
                '${provider.openDisponibility} - ${provider.closeDisponibility}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
